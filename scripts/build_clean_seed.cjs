const fs = require('fs');
const path = require('path');

// 1. Read CSV seed
const csvPath = path.join(__dirname, '../data/customers_seed.csv');
const csvText = fs.readFileSync(csvPath, 'utf8');
const lines = csvText.split(/\r?\n/).filter(l => l.trim());

const csvCustomers = lines.slice(1).map((line, idx) => {
  const cols = line.split(',');
  const empName = (cols[1] || '').trim();
  const rawName = (cols[2] || '').trim();
  const rawCode = (cols[3] || '').trim();
  const rawProv = (cols[5] || cols[4] || '').trim();

  return {
    id: `seed_csv_${idx}`,
    client_id: rawCode,
    shop_code: rawCode,
    client_name: rawName,
    shop_name: rawName,
    province_raw: rawProv,
    province_normalized: rawProv,
    province: rawProv,
    employee_name: empName,
    source: 'csv'
  };
});

// 2. Read SQL shops
const sqlPath = path.join(__dirname, '../data/shops_insert.sql');
let sqlSource = '';
if (fs.existsSync(sqlPath)) {
  sqlSource = fs.readFileSync(sqlPath, 'utf8');
} else {
  sqlSource = fs.readFileSync(path.join(__dirname, 'build_clean_customers.cjs'), 'utf8');
}

const regex = /\('([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']*)',\s*([^\n,]+),\s*'([^']+)',\s*'([^']+)'\)/g;
const sqlShops = [];
let match;
while ((match = regex.exec(sqlSource)) !== null) {
  const saleId = match[5].replace(/^'|'$/g, '').trim();
  sqlShops.push({
    id: match[1],
    client_id: match[2],
    shop_code: match[2],
    client_name: match[3].replace(/\u00a0/g, ' '),
    shop_name: match[3].replace(/\u00a0/g, ' '),
    province_raw: match[4] || '',
    province_normalized: match[4] || '',
    province: match[4] || '',
    salesperson_id: saleId === 'null' ? null : saleId,
    sale_id: saleId === 'null' ? null : saleId,
    status: match[6],
    source: 'sql'
  });
}

console.log(`Loaded ${csvCustomers.length} from CSV, ${sqlShops.length} from SQL.`);

function normStr(str) {
  if (!str) return '';
  return str.replace(/[\u00a0\s]+/g, ' ').trim();
}

function cleanNameForMatch(name) {
  if (!name) return '';
  return name.replace(/\/[a-zA-Z0-9ก-ฮ]+/g, '').replace(/[\u00a0\s]+/g, '').toLowerCase().trim();
}

function getDedupeKeys(c) {
  const keys = [];
  const code = normStr(c.client_id || c.shop_code).toUpperCase();
  const nameClean = cleanNameForMatch(c.client_name || c.shop_name);
  const prov = normStr(c.province_normalized || c.province_raw || c.province).toLowerCase();

  // Deduplicate strictly within the SAME province or matching name+prov
  if (nameClean && prov) {
    keys.push(`NAME:${nameClean}|PROV:${prov}`);
  }
  if (code && code !== '-' && code !== 'N/A' && prov) {
    keys.push(`CODE:${code}|PROV:${prov}`);
  }
  return keys;
}

const keyToGroup = new Map();
const allGroups = [];

// Process SQL shops FIRST so official DB IDs and sales_ids take priority
[...sqlShops, ...csvCustomers].forEach(item => {
  const keys = getDedupeKeys(item);
  let existingGroup = null;

  for (const k of keys) {
    if (keyToGroup.has(k)) {
      existingGroup = keyToGroup.get(k);
      break;
    }
  }

  if (existingGroup) {
    if (item.source === 'sql') {
      existingGroup.id = item.id;
      if (item.salesperson_id) {
        existingGroup.salesperson_id = item.salesperson_id;
        existingGroup.sale_id = item.salesperson_id;
      }
      if (item.client_id && item.client_id !== '-') {
        existingGroup.client_id = item.client_id;
        existingGroup.shop_code = item.client_id;
      }
    }
    if (!existingGroup.employee_name && item.employee_name) {
      existingGroup.employee_name = item.employee_name;
    }
    for (const k of keys) {
      keyToGroup.set(k, existingGroup);
    }
  } else {
    const newObj = { ...item };
    allGroups.push(newObj);
    for (const k of keys) {
      keyToGroup.set(k, newObj);
    }
  }
});

console.log(`Deduplicated total unique stores (with province matching): ${allGroups.length}`);

// Clean up object before saving
const cleanedResult = allGroups.map(c => {
  const client_name = normStr(c.client_name || c.shop_name);
  const client_id = normStr(c.client_id || c.shop_code);
  const province = normStr(c.province_normalized || c.province_raw || c.province);
  return {
    id: c.id,
    client_id: client_id || '-',
    shop_code: client_id || '-',
    client_name: client_name,
    shop_name: client_name,
    province_raw: province,
    province_normalized: province,
    province: province,
    salesperson_id: c.salesperson_id || c.sale_id || null,
    sale_id: c.salesperson_id || c.sale_id || null,
    employee_name: c.employee_name || null
  };
});

const jsonPath = path.join(__dirname, '../data/customers_seed.json');
fs.writeFileSync(jsonPath, JSON.stringify(cleanedResult, null, 2), 'utf8');
console.log(`Successfully written ${cleanedResult.length} unique stores to ${jsonPath}`);
