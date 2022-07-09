create table Paciente(
	idPaciente int identity(1,1) not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	dni char(8) not null,
	idPais char(3) null,
	fnacimiento date not null,
	domicilio varchar(50) null,
	telefono char(9),
	email varchar(30),
	observacion varchar(1000) null,
	fechaAlta datetime not null,
	constraint PK_idPaciente PRIMARY KEY(idPaciente),
)

create table Turno(
	idTurno int identity(1,1) not null,
	fechaTurno datetime, 
	estadoTurno smallint,
	observacion varchar(300),
	constraint PK_idTurno primary key(idTurno),
)

create table Historia(
	idHistoria int identity(1,1) not null,
	fechaHistoria datetime,
	observacion varchar(2000),
	constraint PK_idHistoria primary key (idHistoria),
)

create table HistoriaPaciente(
	idHistoria int,
	idPaciente int,
	idMedico int,
	constraint PK_HistoriaPaciente primary key(idHistoria, idPaciente, idMedico),
)

create table TurnoPaciente(
	idTurno int,
	idPaciente int,
	idMedico int,
	constraint PK_TurnoPaciente primary key(idTurno, idPaciente, idMedico),
)

create table TurnoEstado(
	idestado smallint NOT NULL,
	descripcion varchar(50) NULL,
 constraint PK_TurnoEstado primary key (idestado)
 )

create table Pais(
	idPais char(3) not null,
	pais varchar(20) not null,
	constraint PK_idPais primary key(idPais),
)

create table Especialidad(
	idEspecialidad int identity(1,1) not null primary key,
	especialidad varchar(100) not null
)
create table MedicoEspecialidad(
	idMedico int not null,
	idEspecialidad int not null,
	descripcion varchar(100) not null,
	constraint PK_idEspecialidad primary key(idEspecialidad, idMedico),
)

create table Medico(
	idMedico int identity(1,1) not null,
	nombre varchar(20) not null,
	apellido varchar(30) not null,
	constraint PK_idMedico primary key (idMedico),
)

create table Pago(
	idPago int identity(1,1) not null primary key,
	concepto tinyint not null,
	fecha datetime not null,
	monto money not null,
	estado tinyint,
	observacion varchar(1000),
)

create table PagoPaciente(
	idPago int not null,
	idPaciente int not null,
	idTurno int not null,
	
	primary key(idPago,idPaciente,idTurno)
)

create table Concepto(
	idConcepto tinyint identity(1,1) not null primary key,
	descripcion varchar(500),
)
-----------------------------FOREIGNS KEYS---------------------------------------------------------------------
alter table Paciente add foreign key (idPais) references Pais(idPais);

alter table TurnoPaciente add foreign key (idTurno) references Turno(idTurno);
alter table TurnoPaciente add foreign key (idPaciente) references Paciente(idPaciente);
alter table TurnoPaciente add foreign key (idMedico) references Medico(idMedico);

alter table PagoPaciente add foreign key (idPaciente) references Paciente(idPaciente);
alter table PagoPaciente add foreign key (idPago) references Pago(idPago);
alter table PagoPaciente add foreign key (idTurno) references Turno(idTurno);

alter table MedicoEspecialidad add foreign key (idEspecialidad) references Especialidad(idEspecialidad);

alter table Turno add foreign key (estadoTurno) references TurnoEstado(idestado);

alter table HistoriaPaciente add foreign key (idHistoria) references Historia(idHistoria);
alter table HistoriaPaciente add foreign key (idPaciente) references Paciente(idPaciente);
alter table HistoriaPaciente add foreign key (idMedico) references Medico(idMedico);

alter table Pago add foreign key (concepto) references Concepto(idConcepto);

alter table MedicoEspecialidad add foreign key (idMedico) references Medico(idMedico)
-------------------------TIPO DE DATO DE USUARIO DEFINIDO-------------------------------------------------------
create type paciente from int not null
create type turno from int not null
create type medico from int not null
create type historia from int not null
create type observacion from varchar(1000)
----------------------------------------------------------------------------------------------------------------

--ALTER TABLE medico ALTER COLUMN idMedico medico

--PARA REINICIAR REGISTROS CON IDENTITY
--dbcc CHECKIDENT ('NOMBRE DE LA TABLA', RESEED DEL CAMPO IDENTITY(RESETEO),0->DESDE DONDE QUIERE QUE SE INICIE)
--dbcc CHECKIDENT ('NOMBRE DE LA TABLA', RESEED,0)

--INSERT INTO TurnoEstado VALUES(0, 'Pendiente')
--INSERT INTO TurnoEstado VALUES(1, 'Realizado')
--INSERT INTO TurnoEstado VALUES(2, 'Cancelado')

--drop table Concepto
--drop table Historia
--drop table HistoriaPaciente
--drop table PagoPaciente
--drop table MedicoEspecialidad
--drop table Pago
--drop table Paciente
--drop table Pais
--drop table Turno
--drop table TurnoPaciente
--drop table TurnoEstado
--drop table Medico
--drop table Especialidad

    --USE centromedico
    --GO
    --insert into turno values ( '20200302 13:00', 0 , '' )
    --insert into turno values ( '20200303 14:00', 0 , '')
    --insert into turno values ( '20200303 15:30', 1 , 'El paciente ha sido atendido' )
    --insert into turno values ( '20200305 18:00', 2 , 'El paciente llamó para cancelar el turno' ) 