const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.changeLastMessage = functions.firestore
    .document("rooms/{roomId}/messages/{messageId}")
    .onWrite((change, context) => {
      const message = change.after.data();
      if (message) {
        return db.doc("rooms/" + context.params.roomId).update({
          lastMessages: [message],
        });
      } else {
        return null;
      }
    });
