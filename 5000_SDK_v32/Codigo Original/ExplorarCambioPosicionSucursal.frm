[Forma]
Clave=ExplorarCambioPosicionSucursal
Nombre=<T>Posición a Nivel Sucursal<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=267
PosicionInicialArriba=250
PosicionInicialAltura=517
PosicionInicialAncho=745
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=490
Comentarios=Lista(Info.Sucursal, SQL(<T>SELECT Nombre FROM Sucursal WHERE Sucursal=:nSuc<T>, Info.Sucursal))
ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerCambioPosicionSucursal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroEstilo=Folder (1 línea)
FiltroAplicaEn=(Expresión)
FiltroAplicaExpresion=Asigna(Info.Moneda, FiltroActual)
AutoRefrescar=S
TiempoRefrescar=01:00

[Ficha.Cerrado]
Carpeta=Ficha
Clave=Cerrado
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Inicio]
Carpeta=Ficha
Clave=Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaHoy]
Carpeta=Ficha
Clave=VentaHoy
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta24]
Carpeta=Ficha
Clave=Venta24
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta48]
Carpeta=Ficha
Clave=Venta48
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaHoyMN]
Carpeta=Ficha
Clave=VentaHoyMN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Venta24MN]
Carpeta=Ficha
Clave=Venta24MN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Venta48MN]
Carpeta=Ficha
Clave=Venta48MN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ficha.CompraHoy]
Carpeta=Ficha
Clave=CompraHoy
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CompraHoyMN]
Carpeta=Ficha
Clave=CompraHoyMN
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Compra24]
Carpeta=Ficha
Clave=Compra24
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Compra24MN]
Carpeta=Ficha
Clave=Compra24MN
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Compra48]
Carpeta=Ficha
Clave=Compra48
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Compra48MN]
Carpeta=Ficha
Clave=Compra48MN
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.SaldoHoy]
Carpeta=Ficha
Clave=SaldoHoy
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Saldo24]
Carpeta=Ficha
Clave=Saldo24
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Saldo48]
Carpeta=Ficha
Clave=Saldo48
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Moneda]
Carpeta=Ficha
Clave=Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.BancosHoy]
Carpeta=Ficha
Clave=BancosHoy
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CxpHoy]
Carpeta=Ficha
Clave=CxpHoy
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CxcHoy]
Carpeta=Ficha
Clave=CxcHoy
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PosicionHoy]
Carpeta=Ficha
Clave=PosicionHoy
Editar=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Esp1]
Carpeta=Ficha
Clave=Esp1
Editar=S
Tamano=31
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Posicion48]
Carpeta=Ficha
Clave=Posicion48
Editar=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Posicion24]
Carpeta=Ficha
Clave=Posicion24
Editar=S
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp24]
Carpeta=Ficha
Clave=Cxp24
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxc24]
Carpeta=Ficha
Clave=Cxc24
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp48]
Carpeta=Ficha
Clave=Cxp48
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxc48]
Carpeta=Ficha
Clave=Cxc48
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FechaHoy]
Carpeta=Ficha
Clave=FechaHoy
Editar=S
Tamano=31
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Fecha24]
Carpeta=Ficha
Clave=Fecha24
Editar=S
Tamano=31
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Fecha48]
Carpeta=Ficha
Clave=Fecha48
Editar=S
Tamano=31
ColorFondo=Plata
ColorFuente=Negro

[Ficha.TCCompraHoy]
Carpeta=Ficha
Clave=TCCompraHoy
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TCVentaHoy]
Carpeta=Ficha
Clave=TCVentaHoy
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TCCompra24]
Carpeta=Ficha
Clave=TCCompra24
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TCVenta24]
Carpeta=Ficha
Clave=TCVenta24
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TCCompra48]
Carpeta=Ficha
Clave=TCCompra48
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TCVenta48]
Carpeta=Ficha
Clave=TCVenta48
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Esp2]
Carpeta=Ficha
Clave=Esp2
Editar=S
LineaNueva=S
ValidaNombre=N
EspacioPrevio=S
Tamano=67
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Bancos24]
Carpeta=Ficha
Clave=Bancos24
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.OtrosIngresos]
Carpeta=Ficha
Clave=OtrosIngresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.OtrosEgresos]
Carpeta=Ficha
Clave=OtrosEgresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.DepositosAnticipados]
Carpeta=Ficha
Clave=DepositosAnticipados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ExplorarDinero]
Nombre=ExplorarDinero
Boton=66
NombreEnBoton=S
NombreDesplegar=&Bancos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarCambioDineroSucursal
Activo=S
Visible=S

[Ficha.]
Carpeta=Ficha
Tamano=
ColorFondo=Negro

[Acciones.Sucursal]
Nombre=Sucursal
Boton=16
NombreEnBoton=S
NombreDesplegar=<T>Especificar &Sucursal<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
ConCondicion=S
Multiple=S
ListaAccionesMultiples=Actualizar Vista<BR>Actualizar Titulos
ActivoCondicion=Usuario.CambioVerPosicionOtraSucursal
EjecucionCondicion=Forma(<T>EspecificarSucursal<T>)

[Acciones.Sucursal.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Sucursal.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=CambioPosiciones
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Sucursal, Sucursal)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=CambioPosiciones
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Cerrado, Verdadero)<BR>Asigna(Info.Sucursal, Sucursal)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPantalla
RepPantalla=ExplorarDinero
ExplorarDinero=Sucursal
Sucursal=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Moneda
Moneda=Cerrado
Cerrado=Inicio
Inicio=Esp1
Esp1=BancosHoy
BancosHoy=CompraHoy
CompraHoy=CompraHoyMN
CompraHoyMN=TCCompraHoy
TCCompraHoy=CxcHoy
CxcHoy=VentaHoy
VentaHoy=VentaHoyMN
VentaHoyMN=TCVentaHoy
TCVentaHoy=CxpHoy
CxpHoy=OtrosIngresos
OtrosIngresos=OtrosEgresos
OtrosEgresos=DepositosAnticipados
DepositosAnticipados=SaldoHoy
SaldoHoy=FechaHoy
FechaHoy=PosicionHoy
PosicionHoy=Esp2
Esp2=Bancos24
Bancos24=Compra24
Compra24=Compra24MN
Compra24MN=TCCompra24
TCCompra24=Cxc24
Cxc24=Venta24
Venta24=Venta24MN
Venta24MN=TCVenta24
TCVenta24=Cxp24
Cxp24=Saldo24
Saldo24=Fecha24
Fecha24=Posicion24
Posicion24=Compra48
Compra48=Compra48MN
Compra48MN=TCCompra48
TCCompra48=Cxc48
Cxc48=Venta48
Venta48=Venta48MN
Venta48MN=TCVenta48
TCVenta48=Cxp48
Cxp48=Saldo48
Saldo48=Fecha48
Fecha48=Posicion48
Posicion48=(Fin)
