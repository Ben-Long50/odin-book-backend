import express from 'express';
import cors from 'cors';
import userController from '../controllers/userController.js';

const router = express.Router();

router.post('/signup', cors(), userController.createUser);

router.get('/users/:userId', cors(), userController.getUserById);

export default router;
