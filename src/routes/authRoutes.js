import express from 'express';
import cors from 'cors';
import passport from 'passport';

const router = express.Router();

router.get('/auth/facebook', cors(), passport.authenticate('facebook'));

router.get(
  '/auth/facebook/callback',
  cors(),
  passport.authenticate('facebook', {
    failureRedirect: 'http://localhost:5173/signin',
  }),
  (req, res) => {
    res.status(200).json({ message: 'Facebook auth success' });
  },
);

export default router;
