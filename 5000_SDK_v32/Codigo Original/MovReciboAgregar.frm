[Forma]
Clave=MovReciboAgregar
Nombre=Agregar al Recibo
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=295
PosicionInicialAncho=613
PosicionInicialIzquierda=333
PosicionInicialArriba=347
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAcciones=S
AccionesDivision=S
VentanaExclusiva=S
VentanaEscCerrar=S
IniciarAgregando=S
BarraHerramientas=S
ExpresionesAlMostrar=Asigna(Ult.Articulo, Nulo)<BR>Asigna(Ult.Cantidad, Nulo)<BR>Asigna(Ult.CantidadRecibida, Nulo)<BR>Asigna(Ult.Unidad, Nulo)<BR>Asigna(Ult.Factor, Nulo)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovRecibo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)

[Ficha.MovRecibo.CB]
Carpeta=Ficha
Clave=MovRecibo.CB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovRecibo.Articulo]
Carpeta=Ficha
Clave=MovRecibo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N

[Ficha.MovRecibo.Cantidad]
Carpeta=Ficha
Clave=MovRecibo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.MovRecibo.Unidad]
Carpeta=Ficha
Clave=MovRecibo.Unidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovRecibo.Costo]
Carpeta=Ficha
Clave=MovRecibo.Costo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.MovRecibo.Lote]
Carpeta=Ficha
Clave=MovRecibo.Lote
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovRecibo.Caducidad]
Carpeta=Ficha
Clave=MovRecibo.Caducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraAcciones=S
Multiple=S
ListaAccionesMultiples=Guardar Cambios<BR>Aceptar
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, SQL(<T>spMovReciboValidar :tEmpresa, :fFecha, :tModulo, :nID, :tCuenta, :tMov, :tMovID, :tArt, :tSub, :nCant, :tUnidad, :nCosto, :fCad, :tLote<T>, Empresa, Info.Fecha, Info.Modulo, Info.ID, Info.Cuenta, Info.Mov, Info.MovID, MovRecibo:MovRecibo.Articulo, MovRecibo:MovRecibo.SubCuenta, MovRecibo:MovRecibo.Cantidad, MovRecibo:MovRecibo.Unidad, MovRecibo:MovRecibo.Costo, MovRecibo:MovRecibo.Caducidad, MovRecibo:MovRecibo.Lote))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Temp.Texto

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
EnBarraAcciones=S

[Acciones.Aceptar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=57
NombreDesplegar=&Examinar
TipoAccion=Expresion
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
Expresion=ReportePantalla(Info.Modulo, Afectar.ID)
ActivoCondicion=ConDatos(Afectar.ID)

[Ficha.CantidadOrdenada]
Carpeta=Ficha
Clave=CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Ficha.CantidadRecibida]
Carpeta=Ficha
Clave=CantidadRecibida
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.CantidadPendiente]
Carpeta=Ficha
Clave=CantidadPendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Ficha.UnidadOrdenada]
Carpeta=Ficha
Clave=UnidadOrdenada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Costo]
Nombre=Costo
Boton=30
NombreEnBoton=S
NombreDesplegar=&Sugerir Costo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(MovRecibo:MovRecibo.Costo, <BR>Si<BR>  ConDatos(Afectar.ID)<BR>Entonces<BR>  Caso Info.Modulo<BR>    Es <T>COMS<T> Entonces SQL(<T>SELECT MIN(Costo/Factor) FROM CompraD WHERE ID=:tID AND Articulo=:tArt<T>, Afectar.ID, MovRecibo:MovRecibo.Articulo)*UnidadFactor(MovRecibo:MovRecibo.Unidad)<BR>    Es <T>INV<T>  Entonces SQL(<T>SELECT MIN(Costo/Factor) FROM InvD    WHERE ID=:tID AND Articulo=:tArt<T>, Afectar.ID, MovRecibo:MovRecibo.Articulo)*UnidadFactor(MovRecibo:MovRecibo.Unidad)<BR>  Fin<BR>Sino<BR>  MovRecibo:Art.CostoEstandar*UnidadFactor(MovRecibo:MovRecibo.Unidad) <BR>Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Examinar
Examinar=Costo
Costo=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MovRecibo.CB
MovRecibo.CB=MovRecibo.Articulo
MovRecibo.Articulo=Art.Descripcion1
Art.Descripcion1=CantidadOrdenada
CantidadOrdenada=CantidadPendiente
CantidadPendiente=CantidadRecibida
CantidadRecibida=UnidadOrdenada
UnidadOrdenada=MovRecibo.Cantidad
MovRecibo.Cantidad=MovRecibo.Unidad
MovRecibo.Unidad=MovRecibo.Costo
MovRecibo.Costo=MovRecibo.Caducidad
MovRecibo.Caducidad=MovRecibo.Lote
MovRecibo.Lote=(Fin)
