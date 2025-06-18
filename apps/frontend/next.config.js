/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    appDir: true,
  },
  images: {
    domains: ['localhost'],
  },
  env: {
    CUSTOM_KEY: process.env.CUSTOM_KEY,
  },
  // Enable standalone output for Docker
  output: 'standalone',
  // Disable x-powered-by header
  poweredByHeader: false,
  // Enable compression
  compress: true,
}

module.exports = nextConfig 