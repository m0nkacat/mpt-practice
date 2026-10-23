using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using pr1.Models;

namespace pr1.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        public IActionResult User_input()
        {
            ViewBag.Title = "¬веди данные пж пж пж";
            return View();
        }
        [HttpPost]
        public IActionResult User_input(string word1, string word2, string word3)
        {
            HttpContext.Session.SetString("CardNumber", word1);
            HttpContext.Session.SetString("ExpiryDate", word2);
            HttpContext.Session.SetString("CVV", word3);
            return RedirectToAction("Profile");
        }
        public IActionResult Profile()
        {
            ViewBag.CardNumber = HttpContext.Session.GetString("CardNumber");
            ViewBag.ExpiryDate = HttpContext.Session.GetString("ExpiryDate");
            ViewBag.CVV = HttpContext.Session.GetString("CVV");
            return View();
        }
    }
}
