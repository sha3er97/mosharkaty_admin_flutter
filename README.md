# flutter_mosharkaty

Flutter web project to support mosharkaty app

## deployment instructions :

1. delete all contents of build/web

2. Build for web :
   > flutter build web --web-renderer html --release
3. Move build/web --> /public
4. Move firestore.indexes.json , firebase.json , firestore.rules -->
   /public - if changed -
5. You can test locally before deployment
   > firebase serve --only hosting
6. Deploy a new release
   > firebase deploy --only hosting:mosharkaty-admin

7. Use [deployment URL](https://mosharkaty-admin.web.app/) or
   > https://mosharkaty-admin.web.app/

#to change icon
> flutter pub run flutter_launcher_icons