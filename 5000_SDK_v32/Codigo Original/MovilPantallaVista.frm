

[Forma]
Clave=MovilPantallaVista
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Pantallas Móvil

ListaCarpetas=Lista
PosicionInicialIzquierda=556
PosicionInicialArriba=234
PosicionInicialAlturaCliente=405
PosicionInicialAncho=592
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=248
ExpresionesAlMostrar=EjecutarSQL(<T>spPreparaPantallaVista :tEmpresa<T>,Empresa)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovilPantallaVista
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S

FiltroGeneral=Empresa = {Comillas(Empresa)}
[Lista.MovilPantallaVista.Pantalla]
Carpeta=Lista
Clave=MovilPantallaVista.Pantalla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MovilPantallaVista.Vista]
Carpeta=Lista
Clave=MovilPantallaVista.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Pantalla=124
Vista=325








Campo=604
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

GuardarAntes=S
[Acciones.Campos]
Nombre=Campos
Boton=47
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S








EspacioPrevio=S
Antes=S
NombreEnBoton=S
Expresion=Asigna( Info.ID , MovilPantallaVista:MovilPantallaVista.IDMovilVista )<BR> Forma( <T>MovilVistaCampo<T> )
AntesExpresiones=Asigna(Info.Forma,MovilPantallaVista:MovilPantallaVista.Pantalla)<BR>Asigna(Info.Vista,MovilPantallaVista:MovilPantallaVista.Vista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




























































































[Lista.ListaEnCaptura]
(Inicio)=MovilPantallaVista.Pantalla
MovilPantallaVista.Pantalla=MovilPantallaVista.Vista
MovilPantallaVista.Vista=(Fin)
















































































[Acciones.Mail]
Nombre=Mail
Boton=84
NombreEnBoton=S
NombreDesplegar=&Configurar Correo
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S



EspacioPrevio=S














[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Campos
Campos=Mail
Mail=(Fin)
