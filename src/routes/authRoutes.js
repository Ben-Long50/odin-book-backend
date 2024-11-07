import express from 'express';
import cors from 'cors';
import passport from 'passport';
import userController from '../controllers/userController.js';
import {
  sendAuthStatus,
  signout,
  signin,
  verifyAuthentication,
} from '../passport/passport.js';

const router = express.Router();

router.get('/status', (req, res) =>
  res.status(200).json({ message: 'Service is running' }),
);

router.post('/signin', userController.authenticateUser, signin);

router.post(
  '/signout',
  verifyAuthentication,
  signout,
  userController.deleteUser,
);

router.get('/auth/status', sendAuthStatus);

router.get('/auth/google', cors(), passport.authenticate('google'));

router.get(
  '/auth/google/callback',
  cors(),
  passport.authenticate('google', {
    failureRedirect: '/auth/failure',
    successRedirect: '/auth/success',
  }),
);

router.get('/auth/facebook', cors(), passport.authenticate('facebook'));

router.get(
  '/auth/facebook/callback',
  cors(),
  passport.authenticate('facebook', {
    failureRedirect: '/auth/failure',
    successRedirect: '/auth/success',
  }),
);

router.get('/auth/success', (req, res) => {
  const redirectUrl = `${process.env.CLIENT_URL}/home`;
  res.redirect(redirectUrl);
});

router.get('/auth/failure', (req, res) => {
  const message = 'Email is already associated with another sign in option';
  const redirectUrl = `${process.env.CLIENT_URL}/signin?error=${message}&status=400`;
  res.redirect(redirectUrl);
});

export default router;
