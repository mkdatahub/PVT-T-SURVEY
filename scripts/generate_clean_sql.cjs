const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const jsonPath = path.join(__dirname, '../data/customers_seed.json');
const json = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));

const sqlLines = json.map(c => {
  const id = c.id && /^[0-9a-f-]{36}$/i.test(c.id) ? c.id : crypto.randomUUID();
  const code = (c.client_id || c.shop_code || '-').replace(/'/g, "''");
  const name = (c.client_name || c.shop_name || 'ร้านค้า').replace(/'/g, "''");
  const prov = (c.province_normalized || c.province_raw || c.province || '-').replace(/'/g, "''");
  const saleId = c.salesperson_id && /^[0-9a-f-]{36}$/i.test(c.salesperson_id) ? `'${c.salesperson_id}'` : 'NULL';

  return `('${id}', '${code}', '${name}', '${prov}', ${saleId}, 'active', NOW())`;
});

const sqlContent = `-- SQL Script for Supabase "shops" table (915 Stores)
-- Run this in Supabase SQL Editor if you want to sync all stores directly to Supabase

INSERT INTO public.shops (id, shop_code, shop_name, province, salesperson_id, status, created_at)
VALUES
${sqlLines.join(',\n')}
ON CONFLICT (id) DO UPDATE SET
  shop_code = EXCLUDED.shop_code,
  shop_name = EXCLUDED.shop_name,
  province = EXCLUDED.province,
  salesperson_id = EXCLUDED.salesperson_id;
`;

const outputPath = path.join(__dirname, '../data/shops_insert_clean.sql');
fs.writeFileSync(outputPath, sqlContent, 'utf8');
console.log(`Generated ${outputPath} with ${json.length} store records.`);
