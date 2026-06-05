using System.Linq;
using System.Windows;
using System.Windows.Controls;
using DriverApp.Models;

namespace DriverApp.Views
{
    public partial class CargoExchange : Page
    {
        private string currentDriverId;
        private TransLogisticContext db;

        public CargoExchange(string driverId)
        {
            InitializeComponent();
            currentDriverId = driverId;
            db = new TransLogisticContext();
            LoadOrders();
        }

        private void LoadOrders()
        {
            var orders = db.Orders
                .Where(o => o.StatusId == 1) // Поиск машины
                .Select(o => new {
                    o.Id,
                    o.OrderDate,
                    o.WeightKg,
                    o.VolumeM3,
                    o.Price,
                    o.IsUrgent
                }).ToList();
            dgvOrders.ItemsSource = orders;
        }

        private void btnTakeOrder_Click(object sender, RoutedEventArgs e)
        {
            var selected = dgvOrders.SelectedItem as dynamic;
            if (selected == null) return;
            string orderId = selected.Id;
            // вызов хранимой процедуры sp_AssignDriverToOrder
            var result = db.Database.ExecuteSqlRaw("EXEC sp_AssignDriverToOrder @p0, @p1, @p2", orderId, currentDriverId, selected.Price);
            if (result >= 0)
                MessageBox.Show("Заказ успешно взят!");
            LoadOrders();
        }
    }
}
