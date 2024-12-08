import express from 'express';
import commentController from '../controllers/commentController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.post(
  '/comments/:id/likes',
  verifyAuthentication,
  commentController.likeComment,
);

router.delete(
  '/comments/:commentId',
  verifyAuthentication,
  commentController.deleteComment,
);

router.delete(
  '/comments/:id/likes',
  verifyAuthentication,
  commentController.unlikeComment,
);

export default router;
