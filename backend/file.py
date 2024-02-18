import os
import boto3
import psycopg2
from flask import Flask, render_template, jsonify, send_file
from flask import Flask, render_template, request, url_for, redirect


app = Flask(__name__)


def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="flask_db",
        user=os.environ["DB_USERNAME"],
        password=os.environ["DB_PASSWORD"],
    )
    return conn


@app.route("/get_image")
def get_image():
    s3 = boto3.client("s3")
    # Replace 'your_bucket_name' and 'your_image_key' with the actual bucket name and image key
    image_data = s3.get_object(Bucket="your_bucket_name", Key="your_image_key")[
        "Body"
    ].read()
    return send_file(image_data, mimetype="image/jpeg")  # Adjust mimetype as needed


@app.route("/")
def home():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM products;")
    books = cur.fetchall()
    cur.close()
    conn.close()
    return books


@app.route("/products")
def products():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM products;")
    products = cur.fetchall()
    products_list = []
    for product in products:
        product_dict = {
            "id": product[0],
            "title": product[1],
            "seller": product[2],
            "buyer": product[3],
            "price": product[4],
            "description": product[5],
            "date_added": product[6],
        }
        products_list.append(product_dict)

    cur.close()
    conn.close()
    return products_list


@app.route("/services")
def services():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM services;")
    services = cur.fetchall()

    # Convert the fetched data into a list of dictionaries
    services_list = []
    for service in services:
        service_dict = {
            "id": service[0],
            "title": service[1],
            "seller": service[2],
            "price": service[3],
            "description": service[4],
            "buyer": service[5] if service[5] else [],
            "date_added": service[6].isoformat() if service[6] is not None else None,
        }
        services_list.append(service_dict)

    cur.close()
    conn.close()

    # Return the JSON response
    return jsonify(services_list)


@app.route("/productbuy/<buyer>")
def products_buyer(buyer):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM products WHERE buyer = %s;", (buyer,))
    products = cur.fetchall()
    products_list = []
    for product in products:
        product_dict = {
            "id": product[0],
            "title": product[1],
            "seller": product[2],
            "buyer": product[3],
            "price": product[4],
            "description": product[5],
            "date_added": product[6],
        }
        products_list.append(product_dict)

    cur.close()
    conn.close()
    return jsonify(products_list)


@app.route("/servicebuy/<buyer>")
def services_buyer(buyer):
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute the SQL query with a WHERE clause to filter services by current buyer
    cur.execute("SELECT * FROM services WHERE %s = ANY (buyer);", (buyer,))
    services = cur.fetchall()

    # Convert the fetched data into a list of dictionaries
    services_list = []
    for service in services:
        service_dict = {
            "id": service[0],
            "title": service[1],
            "seller": service[2],
            "price": service[3],
            "description": service[4],
            "buyer": service[5] if service[5] else [],
            "date_added": service[6].isoformat() if service[6] is not None else None,
        }
        services_list.append(service_dict)

    cur.close()
    conn.close()

    # Return the JSON response
    return jsonify(services_list)


@app.route("/productsell/<seller>")
def products_seller(seller):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM products WHERE seller = %s;", (seller,))
    products = cur.fetchall()
    products_list = []
    for product in products:
        product_dict = {
            "id": product[0],
            "title": product[1],
            "seller": product[2],
            "buyer": product[3],
            "price": product[4],
            "description": product[5],
            "date_added": product[6],
        }
        products_list.append(product_dict)

    cur.close()
    conn.close()
    return jsonify(products_list)


@app.route("/servicesell/<seller>")
def services_seller(seller):
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute the SQL query with a WHERE clause to filter services by current buyer
    cur.execute("SELECT * FROM services WHERE seller = %s", (seller,))
    services = cur.fetchall()
    services_list = []
    for service in services:
        service_dict = {
            "id": service[0],
            "title": service[1],
            "seller": service[2],
            "price": service[3],
            "description": service[4],
            "buyer": service[5] if service[5] else [],
            "date_added": service[6].isoformat() if service[6] is not None else None,
        }
        services_list.append(service_dict)

    cur.close()
    conn.close()

    # Return the JSON response
    return jsonify(services_list)


@app.route("/create_product", methods=["POST"])
def create_product():
    if request.method == "POST":
        data = request.json
        if data:
            title = data.get("title")
            seller = data.get("seller")
            price = data.get("price")
            description = data.get("description")

        if title and seller and price and description:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO products (title, seller, price, description)"
                "VALUES (%s, %s, %s, %s)",
                (title, seller, price, description),
            )
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"message": "Product created successfully"}), 200
        else:
            return jsonify({"error": "Missing required fields"}), 400
    else:
        return jsonify({"error": "Invalid JSON data provided"}), 400


@app.route("/update_product/<int:product_id>", methods=["PUT"])
def update_product(product_id):
    if request.method == "PUT":
        data = request.json
        if data:
            buyer = data.get("buyer")

            if buyer:
                conn = get_db_connection()
                cur = conn.cursor()
                cur.execute(
                    "UPDATE products SET buyer = %s WHERE id = %s",
                    (buyer, product_id),
                )
                conn.commit()
                cur.close()
                conn.close()
                return jsonify({"message": "Product updated successfully"}), 200
            else:
                return jsonify({"error": "Buyer information is missing"}), 400
        else:
            return jsonify({"error": "Invalid JSON data provided"}), 400


@app.route("/update_service/<int:service_id>", methods=["PUT"])
def update_service(service_id):
    if request.method == "PUT":
        data = request.json
        if data:
            buyer = data.get("buyer")

            if buyer:
                conn = get_db_connection()
                cur = conn.cursor()
                cur.execute("SELECT buyer FROM services WHERE id = %s", (service_id,))
                current_buyers = cur.fetchone()[0]

                if current_buyers:
                    updated_buyers = current_buyers + [buyer]
                else:
                    updated_buyers = [buyer]

                # Update the database with the updated array of buyers
                cur.execute(
                    "UPDATE services SET buyer = %s WHERE id = %s",
                    (updated_buyers, service_id),
                )
                conn.commit()
                cur.close()
                conn.close()
                return jsonify({"message": "Service updated successfully"}), 200
            else:
                return jsonify({"error": "Buyer information is missing"}), 400
        else:
            return jsonify({"error": "Invalid JSON data provided"}), 400


@app.route("/create_service/", methods=("GET", "POST"))
def create_service():
    if request.method == "POST":
        data = request.json
        if data:
            title = data.get("title")
            seller = data.get("seller")
            price = int(data.get("price"))
            description = data.get("description")

        if title and seller and price and description:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO services (title, seller, price, description)"
                "VALUES (%s, %s, %s, %s)",
                (title, seller, price, description),
            )
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"message": "Service created successfully"}), 200
        else:
            return jsonify({"error": "Missing required fields"}), 400
    else:
        return jsonify({"error": "Invalid JSON data provided"}), 400


@app.route("/products/<int:product_id>")
def get_product(product_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM products WHERE id = %s", (product_id,))
    product = cur.fetchone()
    cur.close()
    conn.close()
    if product:
        return render_template("product.html", product=product)
    else:
        return "Product not found", 404


@app.route("/services/<int:service_id>")
def get_service(service_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM services WHERE id = %s", (service_id,))
    product = cur.fetchone()
    cur.close()
    conn.close()
    if product:
        return render_template("product.html", product=product)
    else:
        return "Product not found", 404


@app.route("/products/<int:product_id>", methods=["DELETE"])
def delete_product(product_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM products WHERE id = %s", (product_id,))
    conn.commit()
    cur.close()
    conn.close()
    return "Product deleted successfully", 200


@app.route("/services/<int:service_id>", methods=["DELETE"])
def delete_service(service_id):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM services WHERE id = %s", (service_id,))
    conn.commit()
    cur.close()
    conn.close()
    return "Service deleted successfully", 200
