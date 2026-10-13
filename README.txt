MI TV STORE — TIENDA COMPLETA
=============================

ARQUITECTURA:
- Netlify: aloja gratis la página.
- Supabase: base de datos + usuarios + almacenamiento de APK.
- La página pública está en /index.html.
- El panel para subir APK está en /admin/.

PASO 1 — CREAR SUPABASE
1. Creá una cuenta en Supabase.
2. Creá un proyecto Free.
3. En SQL Editor, pegá TODO el contenido de supabase.sql y ejecutalo.
4. En Authentication > Users, creá tu usuario administrador con email y contraseña.
5. En Project Settings > API copiá:
   - Project URL
   - anon/publishable key
6. Abrí assets/config.js y reemplazá:
   PEGAR_SUPABASE_URL
   PEGAR_SUPABASE_ANON_KEY
   por tus datos.

IMPORTANTE:
Nunca pongas la service_role key en config.js ni en el navegador.

PASO 2 — NETLIFY
1. Descomprimí este ZIP.
2. Subí la carpeta completa a Netlify.
3. Abrí tu web.
4. Para administrar: TU-WEB/admin/

PASO 3 — SUBIR UNA APP
1. Entrá a /admin/
2. Iniciá sesión con el usuario creado en Supabase.
3. Poné nombre, versión y descripción.
4. Elegí un archivo .apk.
5. Tocá "Subir aplicación".
6. La app aparecerá automáticamente en la página principal.

LÍMITE GRATUITO:
Supabase Free incluye 1 GB de Storage y permite archivos de hasta 50 MB en el plan Free. También tiene límites de transferencia, así que si mucha gente descarga APK grandes, puede alcanzarse el límite.

NOTA SOBRE APK:
Esta tienda guarda los APK en Supabase Storage y genera una URL directa. El botón no cambia el archivo a .bin.

Si un APK pesa más de 50 MB, esta configuración gratuita de Supabase no podrá subirlo.
