export default {
  async fetch(request, env) {
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, HEAD, POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
    };

    // Handle preflight requests from the browser
    if (request.method === "OPTIONS") return new Response(null, { headers: corsHeaders });

    const url = new URL(request.url);

    // Only respond to the API path
    if (url.pathname === "/api/tree") {
      const ghUrl = env.GITHUB_REPO_URL || "https://api.github.com/repos/Pixelated-Grunt/XDF-Mission-Template/git/trees/main?recursive=1";
      const response = await fetch(ghUrl, {
        headers: { 
          "User-Agent": "XDF-Proxy", 
          "Accept": "application/vnd.github.v3+json" 
        }
      });
      return new Response(response.body, { 
        headers: { ...corsHeaders, "Content-Type": "application/json" } 
      });
    }

    return new Response("Not Found", { status: 404 });
  }
};
