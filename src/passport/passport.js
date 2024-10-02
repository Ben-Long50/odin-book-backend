import passport from 'passport';
import userServices from '../services/userServices.js';
import googleStrategy from './passport-google.js';
import facebookStrategy from './passport-facebook.js';
import localStrategy from './passport-local.js';

passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    const user = await userServices.getUserById(id);
    done(null, user);
  } catch (err) {
    done(err);
  }
});

localStrategy(passport);
googleStrategy(passport);
facebookStrategy(passport);

export function verifyAuthentication(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.json({ msg: 'Authentication missing or expired' });
}

export default passport;
