-- Esquema sintético anterior al vínculo entre devoluciones y recepciones.
CREATE TABLE movimientos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  codigo TEXT NOT NULL,
  tipo TEXT NOT NULL,
  empleado TEXT NOT NULL,
  cedula TEXT NOT NULL DEFAULT '',
  departamento TEXT NOT NULL DEFAULT '',
  responsable TEXT NOT NULL DEFAULT '',
  herramientas TEXT NOT NULL DEFAULT '[]',
  observaciones TEXT NOT NULL DEFAULT '',
  estado TEXT NOT NULL DEFAULT 'esperando',
  firma_empleado TEXT,
  firma_responsable TEXT,
  creado_en TEXT NOT NULL,
  firmado_en TEXT
);

INSERT INTO movimientos
  (id, codigo, tipo, empleado, herramientas, estado, firma_empleado, firma_responsable, creado_en, firmado_en)
VALUES
  (1, 'TRX-2020-001', 'ENTREGA', 'Empleado sintético antiguo',
   '[{"descripcion":"Llave sintética","cantidad":"1","estado":"Bueno"},{"descripcion":"Pinza sintética","cantidad":"1","estado":"Regular"}]',
   'firmado', '1-empleado.png', '1-responsable.png', '2020-02-01T13:00:00.000Z', '2020-02-01T13:01:00.000Z'),
  (2, 'TRX-2020-002', 'DEVOLUCION', 'Empleado sintético antiguo',
   '[{"descripcion":"Llave sintética","cantidad":"1","estado":"Bueno"}]',
   'firmado', '2-empleado.png', NULL, '2020-02-02T13:00:00.000Z', '2020-02-02T13:01:00.000Z');
