import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.createUserRecord = functions.auth.user().onCreate(async user => {
  const data = {
    uid: user.uid,
    email: user.email,
    display_name: user.displayName
  };
  return admin
    .firestore()
    .collection("users")
    .add(data);
});
