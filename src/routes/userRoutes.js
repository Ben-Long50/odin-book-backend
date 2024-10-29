import express from 'express';
import cors from 'cors';
import userController from '../controllers/userController.js';
import { signin, verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.post('/signup', cors(), userController.createUser);

router.post(
  '/signin/guest',
  userController.createGuestUser,
  userController.authenticateUser,
  signin,
);

router.get('/users', verifyAuthentication, userController.getUserById);

router.put('/users', verifyAuthentication, userController.editUser);

router.delete('/users', userController.deleteUser);

export default router;
