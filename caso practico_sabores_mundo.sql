--Encontrar el número de artículos en el menú
-- 32
select count (distinct menu_item_id)from menu_items;
--¿Cuál es el artículo más caro y menos caro del menú?
--El más caro es Shrimp Scampi. El menos caro es el Edamame.
select item_name,price from menu_items
order by 2 desc
limit 1;
select item_name, price from menu_items
order by 2 
limit 1;
--¿Cuántos platos américanos hay en el menú?
-- Hay 6 platos americanos.
select count (distinct item_name) from menu_items
where category='American';
--¿Cuál es el precio promedio de los platos?
--El precio promedio de los platos es de 13.3
select round(avg (price),1)from menu_items;

--¿Cuántos pedidos únicos se realizaron en total?
--Pedidos únicos fueron 12234
select count (distinct order_details_id) from order_details;

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
-- Los pedidos con más artículos fueron: 47,82,9,26 y 104
select order_id, item_id from order_details 
where item_id is not null
order by 2 desc
limit 5;
--¿Cuándo se realizó el primer pedido y el último pedido?
--Primer pedido: 2023-01-01. Último pedido 2023-03-31
select order_id, order_date from order_details
order by 2 
limit 1;
select order_id, order_date from order_details
order by 2 desc
limit 1;
-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
-- Se hicieron 702 pedidos

select count (order_id) from order_details
where order_date between '2023-01-01' AND '2023-01-05'

-- Realizar un left join entre entre order_details y menu_items con el identificador
 item_id(tabla order_details) y menu_item_id(tabla menu_items)
 select*from order_details as D
 left join menu_items as I
 on D.item_id=I.menu_item_id;

--¿Cuáles son los 3 platillos que más piden y los 3 que menos se piden?
-- Los 3 platillos que más se piden son: Hamburguesa, Edamame y Korean Beef Bowl. 
--Los 3 platillos que menos se piden son: Chicken Tacos, Potstickers y Cheese Lasagna.
select I.item_name as Platillo,
count (D.order_id) as Total_ordenes 
from menu_items as I
left join order_details as D
on I.menu_item_id=D.item_id
group by 1
order by 2 desc
limit 3;
select I.item_name as Platillo,
count (D.order_id) as Total_ordenes 
from menu_items as I
left join order_details as D
on I.menu_item_id=D.item_id
group by 1
order by 2 
limit 3;

-- ¿Cuáles es la categoría que más se pide y cuál es la que menos?
--El tipo de comida que menos se pide es la comida tipo americano.
--El tipo de comida que menos se pide es la comida tipo asiático. 
select I.category, 
count(D.order_id)
from menu_items as I
left join order_details as D
on I.menu_item_id=D.Item_id
group by 1
order by 2
limit 1;
select I.category, 
count(D.order_id)
from menu_items as I
left join order_details as D
on I.menu_item_id=D.Item_id
group by 1
order by 2 desc
limit 1;

--¿Cuánto gastaron los 3 pedido que más caros?, ¿cuáles los que menos?
--Los 3 pedidos donde se gastaron más dinero fueron: 192.15, 191.05, 190.10
--Los 3 pedidos que menos gastaron fue 5.00
select D.order_id as numero_orden, 
sum(I.price) as Total_orden
from order_details as D
left join menu_items as I
on D.Item_Id=I.menu_item_id
group by 1
having SUM(i.PRICE) is not null
order by 2 desc
limit 3;
select D.order_id as numero_orden, 
sum(I.price) as Total_orden
from order_details as D
left join menu_items as I
on D.Item_Id=I.menu_item_id
group by 1
having SUM(i.PRICE) is not null
order by 2 
limit 3;
-- ¿Cuál sería el promedio por orden?
--En promedio cada pedido se gasta 29.80
with total_orden as
(select D.order_id as numero_orden, 
sum(I.price) as Total_orden
from order_details as D
left join menu_items as I
on D.Item_Id=I.menu_item_id
group by 1
having SUM(i.PRICE) is not null)
select round(avg (total_orden),2) as promedio_orden from total_orden


-- ¿Cuál es la fecha en las que más se ganó dinero de los platillos y cuáles en las que menos?
-- El día que más dinero entró de los platillos fue el 2023-02-01 con 2396.35
--El día que menos dinero entró de los platillos fue el 2023-03-22 con 1016.90
select D.order_date as Fecha , 
Sum(I.price) as Ganancia
from order_details as D
left join menu_items as I
on D.Item_Id=I.menu_item_id
group by 1
order by 2 desc 
limit 1;
select D.order_date as Fecha , 
Sum(I.price) as Ganancia
from order_details as D
left join menu_items as I
on D.Item_Id=I.menu_item_id
group by 1
order by 2  
limit 1
