import express from 'express';
import cors from 'cors';
import passport from 'passport';
import userController from '../controllers/userController.js';
import {
  sendAuthStatus,
  signout,
  verifyAuthentication,
} from '../passport/passport.js';

const router = express.Router();

router.post('/signin', userController.authenticateUser, (req, res) => {
  passport.authenticate('local', (error, user) => {
    if (error) {
      res.status(401).json({ message: `Authentication error: ${error}` });
    }
    req.login(user, (error) => {
      if (error) {
        res.status(500).json({ message: `Login error: ${error}` });
      }
      res.status(200).json({ message: 'Login successful' });
    });
  })(req, res);
});

router.post('/signout', signout);

router.get('/auth/status', verifyAuthentication, sendAuthStatus);

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
