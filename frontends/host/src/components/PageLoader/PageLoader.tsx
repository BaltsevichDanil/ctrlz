import { Loader } from "lucide-react";

export const PageLoader = () => {
  return (
    <div className="h-screen flex items-center justify-center">
      <Loader className="animate-spin" />
    </div>
  );
};
