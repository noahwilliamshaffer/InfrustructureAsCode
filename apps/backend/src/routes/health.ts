import { Router, Request, Response } from 'express';

const router = Router();

// Basic health check
router.get('/', (req: Request, res: Response) => {
  res.status(200).json({
    success: true,
    message: 'API is healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    version: '1.0.0',
  });
});

// Detailed health check for monitoring
router.get('/detailed', (req: Request, res: Response) => {
  const healthData = {
    success: true,
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    version: '1.0.0',
    checks: {
      api: {
        status: 'healthy',
        responseTime: Date.now(),
      },
      database: {
        status: 'healthy', // This would check actual DB connection
        responseTime: '<1ms',
      },
      memory: {
        usage: process.memoryUsage(),
        status: 'healthy',
      },
      cpu: {
        usage: process.cpuUsage(),
        status: 'healthy',
      },
    },
  };

  res.status(200).json(healthData);
});

// Liveness probe for Kubernetes
router.get('/live', (req: Request, res: Response) => {
  res.status(200).json({
    status: 'alive',
    timestamp: new Date().toISOString(),
  });
});

// Readiness probe for Kubernetes
router.get('/ready', (req: Request, res: Response) => {
  // Add checks for dependencies like database connection
  const isReady = true; // This would check actual readiness conditions
  
  if (isReady) {
    res.status(200).json({
      status: 'ready',
      timestamp: new Date().toISOString(),
    });
  } else {
    res.status(503).json({
      status: 'not ready',
      timestamp: new Date().toISOString(),
    });
  }
});

export { router as healthRouter }; 