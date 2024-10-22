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
  res
    .status(401)
    .json({ status: false, message: 'Authentication missing or expired' });
}

export function sendAuthStatus(req, res) {
  if (req.user) {
    res.status(200).json({
      status: true,
      message: `Valid authentication as user ${req.user.firstName} ${req.user.lastName}`,
    });
  }
}

export function signout(req, res) {
  req.logout((error) => {
    if (error) {
      res.status(500).json({ message: `Logout error: ${error}` });
    }
    req.session.destroy((error) => {
      if (error) {
        res
          .status(500)
          .json({ message: `Session destruction error: ${error}` });
      }
      res.clearCookie('connect.sid');
      res.status(200).json({ message: 'Logout successful' });
    });
  });
}

export default passport;
