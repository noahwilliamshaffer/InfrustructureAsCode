import { CloudIcon, ServerIcon, CpuChipIcon, ChartBarIcon } from '@heroicons/react/24/outline'

export default function Home() {
  return (
    <main className="relative overflow-hidden">
      {/* Background Effects */}
      <div className="absolute inset-0 bg-[url('/grid.svg')] bg-center [mask-image:linear-gradient(180deg,white,rgba(255,255,255,0))]"></div>
      
      {/* Hero Section */}
      <div className="relative px-6 lg:px-8">
        <div className="mx-auto max-w-7xl pt-20 pb-32 sm:pt-48 sm:pb-40">
          <div className="text-center">
            <h1 className="text-4xl font-bold tracking-tight text-white sm:text-6xl">
              <span className="block">CloudOps</span>
              <span className="block text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-purple-400">
                Dashboard
              </span>
            </h1>
            <p className="mt-6 text-lg leading-8 text-gray-300 max-w-2xl mx-auto">
              Enterprise-grade DevOps platform demonstrating modern Infrastructure-as-Code, 
              containerization, and CI/CD workflows with Next.js and Kubernetes.
            </p>
            <div className="mt-10 flex items-center justify-center gap-x-6">
              <a
                href="#features"
                className="rounded-md bg-blue-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 transition-all duration-200"
              >
                Explore Features
              </a>
              <a
                href="#architecture"
                className="text-sm font-semibold leading-6 text-white hover:text-blue-400 transition-colors"
              >
                View Architecture <span aria-hidden="true">→</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      {/* Features Section */}
      <div id="features" className="py-24 sm:py-32">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="text-3xl font-bold tracking-tight text-white sm:text-4xl">
              Production-Ready Infrastructure
            </h2>
            <p className="mt-6 text-lg leading-8 text-gray-300">
              Built with enterprise-grade tools and best practices for scalability, reliability, and maintainability.
            </p>
          </div>
          <div className="mx-auto mt-16 max-w-2xl sm:mt-20 lg:mt-24 lg:max-w-none">
            <dl className="grid max-w-xl grid-cols-1 gap-x-8 gap-y-16 lg:max-w-none lg:grid-cols-4">
              <div className="flex flex-col items-center text-center">
                <div className="mb-6 flex h-16 w-16 items-center justify-center rounded-lg bg-blue-600/10 backdrop-blur-lg border border-blue-600/20">
                  <CloudIcon className="h-8 w-8 text-blue-400" aria-hidden="true" />
                </div>
                <dt className="text-lg font-semibold leading-7 text-white">
                  Cloud Native
                </dt>
                <dd className="mt-1 text-base leading-7 text-gray-300">
                  Kubernetes-native architecture with Docker containerization and cloud-agnostic deployment.
                </dd>
              </div>
              <div className="flex flex-col items-center text-center">
                <div className="mb-6 flex h-16 w-16 items-center justify-center rounded-lg bg-purple-600/10 backdrop-blur-lg border border-purple-600/20">
                  <ServerIcon className="h-8 w-8 text-purple-400" aria-hidden="true" />
                </div>
                <dt className="text-lg font-semibold leading-7 text-white">
                  Infrastructure as Code
                </dt>
                <dd className="mt-1 text-base leading-7 text-gray-300">
                  Terraform-managed infrastructure with version control and automated provisioning.
                </dd>
              </div>
              <div className="flex flex-col items-center text-center">
                <div className="mb-6 flex h-16 w-16 items-center justify-center rounded-lg bg-green-600/10 backdrop-blur-lg border border-green-600/20">
                  <CpuChipIcon className="h-8 w-8 text-green-400" aria-hidden="true" />
                </div>
                <dt className="text-lg font-semibold leading-7 text-white">
                  CI/CD Automation
                </dt>
                <dd className="mt-1 text-base leading-7 text-gray-300">
                  GitHub Actions workflows with automated testing, security scanning, and deployment.
                </dd>
              </div>
              <div className="flex flex-col items-center text-center">
                <div className="mb-6 flex h-16 w-16 items-center justify-center rounded-lg bg-yellow-600/10 backdrop-blur-lg border border-yellow-600/20">
                  <ChartBarIcon className="h-8 w-8 text-yellow-400" aria-hidden="true" />
                </div>
                <dt className="text-lg font-semibold leading-7 text-white">
                  Monitoring & Observability
                </dt>
                <dd className="mt-1 text-base leading-7 text-gray-300">
                  Comprehensive monitoring with health checks, metrics, and centralized logging.
                </dd>
              </div>
            </dl>
          </div>
        </div>
      </div>

      {/* Architecture Section */}
      <div id="architecture" className="py-24 sm:py-32">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="text-3xl font-bold tracking-tight text-white sm:text-4xl">
              System Architecture
            </h2>
            <p className="mt-6 text-lg leading-8 text-gray-300">
              Modern three-tier architecture with containerized microservices and cloud-native deployment.
            </p>
          </div>
          <div className="mt-16 flow-root">
            <div className="mx-auto max-w-4xl">
              <div className="relative rounded-xl bg-gray-900/5 p-8 backdrop-blur-lg border border-gray-700/50">
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                  <div className="text-center">
                    <div className="mx-auto h-24 w-24 rounded-full bg-blue-600/20 flex items-center justify-center mb-4">
                      <CloudIcon className="h-12 w-12 text-blue-400" />
                    </div>
                    <h3 className="text-lg font-semibold text-white">Frontend</h3>
                    <p className="text-sm text-gray-300 mt-2">Next.js 14 with TypeScript</p>
                    <p className="text-sm text-gray-400">Port: 3000</p>
                  </div>
                  <div className="text-center">
                    <div className="mx-auto h-24 w-24 rounded-full bg-purple-600/20 flex items-center justify-center mb-4">
                      <ServerIcon className="h-12 w-12 text-purple-400" />
                    </div>
                    <h3 className="text-lg font-semibold text-white">Backend API</h3>
                    <p className="text-sm text-gray-300 mt-2">Node.js with Express</p>
                    <p className="text-sm text-gray-400">Port: 8080</p>
                  </div>
                  <div className="text-center">
                    <div className="mx-auto h-24 w-24 rounded-full bg-green-600/20 flex items-center justify-center mb-4">
                      <CpuChipIcon className="h-12 w-12 text-green-400" />
                    </div>
                    <h3 className="text-lg font-semibold text-white">Database</h3>
                    <p className="text-sm text-gray-300 mt-2">PostgreSQL</p>
                    <p className="text-sm text-gray-400">Port: 5432</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Status Section */}
      <div className="py-16 sm:py-24">
        <div className="mx-auto max-w-7xl px-6 lg:px-8">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">
              System Status
            </h2>
            <div className="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="bg-green-600/10 backdrop-blur-lg border border-green-600/20 rounded-lg p-6">
                <div className="flex items-center justify-center mb-2">
                  <div className="h-3 w-3 rounded-full bg-green-400 animate-pulse"></div>
                </div>
                <h3 className="text-lg font-semibold text-white">Frontend</h3>
                <p className="text-sm text-green-400">Operational</p>
              </div>
              <div className="bg-green-600/10 backdrop-blur-lg border border-green-600/20 rounded-lg p-6">
                <div className="flex items-center justify-center mb-2">
                  <div className="h-3 w-3 rounded-full bg-green-400 animate-pulse"></div>
                </div>
                <h3 className="text-lg font-semibold text-white">API</h3>
                <p className="text-sm text-green-400">Healthy</p>
              </div>
              <div className="bg-green-600/10 backdrop-blur-lg border border-green-600/20 rounded-lg p-6">
                <div className="flex items-center justify-center mb-2">
                  <div className="h-3 w-3 rounded-full bg-green-400 animate-pulse"></div>
                </div>
                <h3 className="text-lg font-semibold text-white">Database</h3>
                <p className="text-sm text-green-400">Connected</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  )
} 