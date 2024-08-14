import createError from 'http-errors';
import express from 'express';
import path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import { fileURLToPath } from 'url';
import session from 'express-session';
import passport from 'passport';
import userRouter from './routes/userRoutes.js';
import authRouter from './routes/authRoutes.js';
import './middleware/facebookAuth.js';

const app = express();

app.use(
  session({
    secret: process.env.SECRET_KEY,
    resave: false,
    saveUninitialized: true,
  }),
);

app.use(passport.initialize());
app.use(passport.session());

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
// app.use(helmet());

const limiter = rateLimit({
  windowMs: 2 * 60 * 1000,
  max: 100,
});

app.use(limiter);
app.use(
  cors({
    origin: 'http://localhost:5173',
    credentials: true,
  }),
);

app.use('/', userRouter);
app.use('/', authRouter);

// catch 404 and forward to error handler
app.use((req, res, next) => {
  next(createError(404));
});

// error handler
app.use((err, req, res, next) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // Send JSON error response
  res.status(err.status || 500);
  res.json({
    message: err.message,
    error: req.app.get('env') === 'development' ? err : {},
  });
});

export default app;
