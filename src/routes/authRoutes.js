import express from 'express';
import cors from 'cors';
import passport from 'passport';
import userController from '../controllers/userController.js';

const router = express.Router();

router.post(
  '/signin',
  cors(),
  userController.authenticateUser,
  passport.authenticate('local', {
    failureRedirect: '/auth/failure',
  }),
  (req, res) => {
    res.redirect(`${process.env.CLIENT_URL}/home`);
  },
);

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
