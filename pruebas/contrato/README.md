# Pruebas del contrato móvil

Con Node.js 20 o superior, desde la raíz del repositorio:

```sh
npm ci
node --test pruebas/contrato/contrato.test.js
```

La suite arranca el servidor de este checkout en procesos propios con puertos
libres asignados por el sistema, únicamente en loopback. Verifica que los
puertos no sean 3000 ni 8090. Cada caso empieza en una carpeta temporal vacía
y configura su propio `DATA_DIR`. El caso histórico carga `antigua.sql` y
genera PNG sintéticos antes de arrancar. La suite detiene los procesos y
elimina sus carpetas temporales al terminar.

| Caso ejecutado | Resultado esperado en #12 |
| --- | --- |
| Base vacía y altas simultáneas | Dos respuestas 201, solo el último ID queda activo. Una firma tardía del primero devuelve 400. Cancelar el primero devuelve éxito y deja el segundo activo. |
| Validación y firma | Alta sin empleado y firma sin imagen de empleado devuelven 400 con `error`. La firma sin imagen del responsable aún devuelve 200. La lectura de estado por ID devuelve 404 porque la ruta aún no existe. |
| Recepción rápida y detallada | Series TRX y TRXD independientes. La rápida toma la declaración por defecto; la detallada conserva ficha, declaración e ID de líneas. |
| Devolución parcial y cambio | Se heredan datos de la recepción. Una devolución pendiente de firma no cierra líneas. Un cambio con ID saliente duplicado se rechaza. Un cambio cancelado deja los pendientes intactos y su ID incorporado queda reservado. Un cambio firmado incorpora la herramienta, que luego se devuelve por su ID. |
| Historial y archivos | El ciclo se completa y aparecen los orígenes y cierres calculados. Los PNG descargados coinciden con los escritos, el PDF tiene cabecera y nombre de archivo esperados y el Excel abre con las dos hojas e imágenes. |
| Base antigua | La migración numera las herramientas, asigna modo rápido y conserva código, fecha, firmas y devolución suelta. |
| Respaldo y restauración | Con el escritor detenido, se copia toda la carpeta sintética, se restaura en otra ruta y se vuelve a arrancar. Se comparan filas e historial, se comprueban integridad y referencias SQLite y se vuelven a consultar las firmas y exportaciones. |
| Acceso compartido y SSE | Salud pública, API sin sesión con 401 JSON, redirección de la página de firma, acceso con cookie sintética y latido inicial por SSE local. |

## Casos pendientes del contrato móvil

| Issue | Caso y resultado esperado |
| --- | --- |
| #13 | Vincular una tablet una sola vez, verificar sesión y revocar. Probar 401 tras revocación, 403 para roles indebidos, acceso a estáticos, exportaciones y PNG, y ausencia de datos del turno en una tablet ajena. |
| #14 | Enviar dos altas válidas simultáneas. Esperar una respuesta 201 y una 409 con `MOVIMIENTO_ACTIVO`. Consultar el activo y comprobar que conserva el ID de la respuesta 201. |
| #14 | Simular respuesta de firma o cancelación perdida. Consultar estado por ID incluso si hay otro activo y comprobar `firmado` con fecha o `cancelado` con fecha nula. Probar 404 JSON para ID desconocido y 409 para firma tardía. |
| #14 | Enviar firma incompleta, de tipo inválido o demasiado grande. Esperar error y conservar `esperando`. Provocar un fallo al guardar el segundo PNG y reiniciar a mitad de la operación. Verificar que no se confirma una firma incompleta y que la limpieza conserva los PNG referenciados. |
| #14 | Enviar dos veces el mismo ID de línea en una devolución. Esperar 400 y comprobar que la recepción conserva sus pendientes. |
| #15 y #16 | Integrar el borrador ante conflicto y el sondeo de la tablet. Probar captura con dedo, rotación, quiosco y recuperación por túnel. |
| #17 | Verificar límites de 200 y 1.000 con volumen sintético, contenido y presentación de las exportaciones y retirada de las vistas operativas en el corte. |
| #18 | Ensayar el respaldo operativo y la reversión en el entorno aislado del piloto. |
