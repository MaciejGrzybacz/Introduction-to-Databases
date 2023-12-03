{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "code",
            "source": [
                "-- Podaj wartość zamówienia o numerze 10250 lub numerze mniejszym niż 9000\r\n",
                "USE Northwind;\r\n",
                "SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS Val\r\n",
                "FROM Orders\r\n",
                "INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID\r\n",
                "GROUP BY Orders.OrderID\r\n",
                "HAVING Orders.OrderID = 10250 OR Orders.OrderID < 9000"
            ],
            "metadata": {
                "azdata_cell_guid": "d1c605aa-d9b1-44df-9f66-62608711cad8",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia. Posortuj zamówienia wg maksymalnej ceny produktu\r\n",
                "USE Northwind;\r\n",
                "SELECT Orders.OrderID, MAX(UnitPrice) AS MaxVal\r\n",
                "FROM Orders\r\n",
                "INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID\r\n",
                "GROUP BY Orders.OrderID"
            ],
            "metadata": {
                "azdata_cell_guid": "4804be80-7d2b-438d-aa9e-42ff3b30c7d4",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia.\r\n",
                "USE Northwind;\r\n",
                "SELECT Orders.OrderID, MAX(UnitPrice) AS MaxVal, MIN(UnitPrice) AS MinVal\r\n",
                "FROM Orders\r\n",
                "INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID\r\n",
                "GROUP BY Orders.OrderID"
            ],
            "metadata": {
                "azdata_cell_guid": "33e02bda-1e50-4d5d-ae7a-e0c217d119b2",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Podaj średnią różnicę, pomiędzy maksymalną i minimalną ceną zamawianych produktów\r\n",
                "USE Northwind;\r\n",
                "SELECT AVG(MaxPrice - MinPrice) AS AverageDifference\r\n",
                "FROM (\r\n",
                "    SELECT MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice\r\n",
                "    FROM [Order Details]\r\n",
                "    GROUP BY OrderID\r\n",
                ") AS PriceDifference"
            ],
            "metadata": {
                "azdata_cell_guid": "956d86ea-2884-4980-82d3-529678236be4",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów\r\n",
                "USE Northwind;\r\n",
                "SELECT Shippers.ShipperID, COUNT(Orders.ShipVia) AS CountOfOrders\r\n",
                "FROM Shippers\r\n",
                "LEFT OUTER JOIN Orders ON Shippers.ShipperID=Orders.ShipVia \r\n",
                "GROUP BY Shippers.ShipperID"
            ],
            "metadata": {
                "azdata_cell_guid": "b511480c-76c4-4f3f-8558-0cfeab605928",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Który ze spedytorów był najaktywniejszy w 1997 roku? A który pomiędzy 1990 i 1995 lub 1997 i 2000?\r\n",
                "USE Northwind;\r\n",
                "SELECT TOP 1 ShipVia, COUNT(OrderID) AS OrdersNumber, YEAR(ShippedDate) AS OrderYear\r\n",
                "FROM Orders\r\n",
                "WHERE YEAR(ShippedDate) = '1997'\r\n",
                "GROUP BY ShipVIa, YEAR(ShippedDate)\r\n",
                "ORDER BY OrdersNumber DESC;"
            ],
            "metadata": {
                "azdata_cell_guid": "9c92bd70-5961-4976-bb8d-24809d4354b4",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Wyświetl zamówienia dla których liczba pozycji w zamówieniu jest większa niż 5\r\n",
                "USE Northwind;\r\n",
                "SELECT OrderID, SUM(Quantity)\r\n",
                "FROM [Order Details]\r\n",
                "GROUP BY OrderID\r\n",
                "HAVING SUM(Quantity)>5\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "0f245c27-0d35-4847-8cb8-c23cfd056929",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Wyświetl klientów, dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)\r\n",
                "USE Northwind;\r\n",
                "SELECT CustomerID, YEAR(OrderDate), COUNT(OrderID)\r\n",
                "FROM Orders\r\n",
                "WHERE YEAR(OrderDate) = '1998'\r\n",
                "GROUP BY CustomerID, YEAR(OrderDate)\r\n",
                "HAVING COUNT(OrderID)>8\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "8581f0cd-0474-42e2-9926-c78d8293e3ee",
                "language": "sql",
                "tags": [
                    "hide_input"
                ]
            },
            "outputs": [],
            "execution_count": 44
        }
    ]
}