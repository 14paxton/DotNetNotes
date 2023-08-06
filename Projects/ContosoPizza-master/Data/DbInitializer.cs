using ContosoPizza.Models;

namespace ContosoPizza.Data
{
    public static class DbInitializer
    {
        public static void Initialize(PizzaContext context)
        {

            if (context.Pizzas.Any())
            {
                return;   // DB has been seeded
            }

          

            var pizzas = new Pizza[]
            {
                new Pizza
                    {
                        Name = "Meat Lovers",
                        
                    },
                new Pizza
                    {
                        Name = "Hawaiian",
                     
                    },
                new Pizza
                    {
                        Name="Alfredo Chicken",
                }
            };

            context.Pizzas.AddRange(pizzas);
            context.SaveChanges();
        }
    }
}