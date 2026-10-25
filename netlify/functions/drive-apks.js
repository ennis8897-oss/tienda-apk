exports.handler = async (event) => {
 const key = process.env.DRIVE_API_KEY;
 if (!key) return {statusCode:503,body:JSON.stringify({error:'Falta configurar DRIVE_API_KEY en Netlify.'})};
 const id = event.queryStringParameters?.folderId || '';
 if (!/^[a-zA-Z0-9_-]{10,120}$/.test(id)) return {statusCode:400,body:JSON.stringify({error:'ID de carpeta inválido.'})};
 try {
  let token='',files=[];
  do {
   const params=new URLSearchParams({q:`'${id}' in parents and trashed = false`,fields:'nextPageToken,files(id,name,mimeType,size)',pageSize:'100',key});
   if(token)params.set('pageToken',token);
   const response=await fetch('https://www.googleapis.com/drive/v3/files?'+params);
   const result=await response.json();
   if(!response.ok)throw Error(result.error?.message||'Google Drive no respondió correctamente');
   files.push(...(result.files||[]).filter(f=>f.name?.toLowerCase().endsWith('.apk')&&f.mimeType!=='application/vnd.google-apps.folder'));
   token=result.nextPageToken||'';
  }while(token&&files.length<300);
  return {statusCode:200,headers:{'Content-Type':'application/json','Cache-Control':'no-store'},body:JSON.stringify({files:files.slice(0,300)})};
 }catch(e){return {statusCode:502,body:JSON.stringify({error:e.message+' Revisá que la carpeta sea pública y que la API de Drive esté habilitada.'})}}
};
