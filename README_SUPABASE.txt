MI TV STORE — VERSIÓN SUPABASE

1) Abrí tu proyecto de Supabase > SQL Editor > New query.
2) Copiá y ejecutá todo el archivo supabase-setup.sql.
3) En Authentication > Users, creá el usuario administrador con tu correo y contraseña. Desactivá el registro público.
4) En Project Settings > API, copiá Project URL y publishable key (o anon key).
5) Pegá esos dos valores en assets/config.js, reemplazando PEGAR_SUPABASE_URL y PEGAR_SUPABASE_ANON_KEY.
   Nunca uses la service_role/secret key en el navegador.
6) Publicá la carpeta completa en Netlify.
7) Abrí /admin/, iniciá sesión y subí APK individuales de hasta 50 MB.

El catálogo público usa la tabla apps y los archivos se guardan en el bucket público apks.
Los archivos que estuvieran previamente en Firebase o Google Drive no se copian automáticamente.
