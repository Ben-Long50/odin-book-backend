import createError from 'http-errors';
import express from 'express';
import path from 'path';
import logger from 'morgan';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import { fileURLToPath } from 'url';
import session from 'express-session';
import passport from 'passport';
import connectPgSimple from 'connect-pg-simple';
import pkg from 'pg';
import cron from 'node-cron';
import userRouter from './routes/userRoutes.js';
import authRouter from './routes/authRoutes.js';
import profileRouter from './routes/profileRoutes.js';
import searchRouter from './routes/searchRoutes.js';
import postRouter from './routes/postRoutes.js';
import commentRouter from './routes/commentRoutes.js';
import notificationRouter from './routes/notificationRoutes.js';
import './passport/passport.js';
import userController from './controllers/userController.js';

const app = express();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const { Pool } = pkg;
const pgPool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

const PgSession = connectPgSimple(session);

const limiter = rateLimit({
  windowMs: 2 * 60 * 1000,
  max: 100,
});

if (process.env.NODE_ENV === 'production') {
  app.set('trust proxy', 1);
}

app.use(
  cors({
    origin: process.env.CLIENT_URL,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With'],
    credentials: true,
  }),
);

const sess = {
  secret: process.env.SECRET_KEY,
  resave: false,
  saveUninitialized: false,
  store: new PgSession({
    pool: pgPool,
    tableName: 'session',
  }),
  cookie: {
    maxAge: 4 * 60 * 60 * 1000,
    secure: process.env.NODE_ENV === 'production',
    sameSite: process.env.NODE_ENV === 'production' && 'none',
    httpOnly: true,
  },
};

app.use(session(sess));
app.use(passport.session());

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));
app.use(helmet());

app.use(limiter);

app.use('/', userRouter);
app.use('/', authRouter);
app.use('/', profileRouter);
app.use('/', searchRouter);
app.use('/', postRouter);
app.use('/', commentRouter);
app.use('/', notificationRouter);

cron.schedule('0 * * * *', () => {
  console.log('Running account cleanup...');
  userController.deleteExpiredGuests();
});

// catch 404 and forward to error handler
app.use((req, res, next) => {
  next(createError(404));
});

// error handler
app.use((err, req, res, next) => {
  if (res.headersSent) {
    return next(err);
  }
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = process.env.NODE_ENV === 'development' ? err : {};

  // Send JSON error response
  res.status(err.status || 500).json({
    message: err.message,
    error: process.env.NODE_ENV === 'development' ? err : {},
  });
});

export default app;
