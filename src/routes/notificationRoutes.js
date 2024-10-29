import express from 'express';
import { verifyAuthentication } from '../passport/passport.js';
import notificationController from '../controllers/notificationController.js';

const router = express.Router();

router.post(
  '/notifications',
  verifyAuthentication,
  notificationController.createShareNotification,
);

router.delete(
  '/notifications/:id',
  verifyAuthentication,
  notificationController.deleteNotification,
);

router.delete(
  '/notifications',
  verifyAuthentication,
  notificationController.deleteAllNotifications,
);

export default router;
