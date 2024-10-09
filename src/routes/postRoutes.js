import express from 'express';
import postController from '../controllers/postController.js';

const router = express.Router();

router.post('/post', postController.createPost);

export default router;
