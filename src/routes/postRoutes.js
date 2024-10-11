import express from 'express';
import postController from '../controllers/postController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.get('/posts/:id', verifyAuthentication, postController.getFollowedPosts);

export default router;
