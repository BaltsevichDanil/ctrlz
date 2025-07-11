import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import { Suspense } from "react";
import { ErrorBoundary } from "./components/ErrorBoundary";
import { NotFound } from "./features/NotFound";
import { PageLoader } from "./components/PageLoader";
import { Signin } from "auth/Signin";

const App = () => {
  return (
    <Router>
      <ErrorBoundary>
        <Suspense fallback={<PageLoader />}>
          <Routes>
            <Route path="/" element={<Navigate to="/dashboard" replace />} />

            <Route
              path="/auth/*"
              element={
                <Signin />
              }
            />

            <Route path="*" element={<NotFound />} />
          </Routes>
        </Suspense>
      </ErrorBoundary>
    </Router>
  );
};

export default App;
