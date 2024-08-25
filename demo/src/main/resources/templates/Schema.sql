# Define tables based on the SQL schema

class Users(Base):
    __tablename__ = 'Users'
    user_id = Column(Integer, primary_key=True)
    first_name = Column(String(100), nullable=False)
    last_name = Column(String(100), nullable=False)
    email = Column(String(150), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    phone_number = Column(String(20))
    address = Column(String(255))
    city = Column(String(100))
    country = Column(String(100))
    postal_code = Column(String(20))
    date_of_birth = Column(Date)
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)


class Locations(Base):
    __tablename__ = 'Locations'
    location_id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    address = Column(String(255), nullable=False)
    city = Column(String(100), nullable=False)
    country = Column(String(100), nullable=False)
    postal_code = Column(String(20))
    phone_number = Column(String(20))
    opening_hours = Column(String(50))
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)


class Vehicles(Base):
    __tablename__ = 'Vehicles'
    vehicle_id = Column(Integer, primary_key=True)
    model = Column(String(100), nullable=False)
    brand = Column(String(100), nullable=False)
    category = Column(String(50), nullable=False)
    license_plate = Column(String(20), unique=True, nullable=False)
    availability = Column(Boolean, default=True)
    daily_rate = Column(DECIMAL(10, 2), nullable=False)
    location_id = Column(Integer, ForeignKey('Locations.location_id'))
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)


class Reservations(Base):
    __tablename__ = 'Reservations'
    reservation_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('Users.user_id', ondelete="CASCADE"))
    vehicle_id = Column(Integer, ForeignKey('Vehicles.vehicle_id', ondelete="SET NULL"))
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    total_price = Column(DECIMAL(10, 2), nullable=False)
    status = Column(String(50), default='Pending')
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)


class Payments(Base):
    __tablename__ = 'Payments'
    payment_id = Column(Integer, primary_key=True)
    reservation_id = Column(Integer, ForeignKey('Reservations.reservation_id', ondelete="CASCADE"))
    amount = Column(DECIMAL(10, 2), nullable=False)
    payment_date = Column(TIMESTAMP, nullable=False)
    payment_method = Column(String(50))
    status = Column(String(50), default='Completed')
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)


class Reviews(Base):
    __tablename__ = 'Reviews'
    review_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('Users.user_id', ondelete="CASCADE"))
    vehicle_id = Column(Integer, ForeignKey('Vehicles.vehicle_id', ondelete="SET NULL"))
    rating = Column(Integer)
    comment = Column(Text)
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

