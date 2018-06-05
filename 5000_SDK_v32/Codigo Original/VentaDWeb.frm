
[Forma]
Clave=VentaDWeb
Icono=0
Modulos=(Todos)
Nombre=Detalles de Artículo

ListaCarpetas=(Lista)
CarpetaPrincipal=Campos
PosicionInicialIzquierda=508
PosicionInicialArriba=318
PosicionInicialAlturaCliente=377
PosicionInicialAncho=665
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal


PosicionCol1=310
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Mov + <T> <T> + Info.MovID, Info.Articulo, Info.Renglon)
[Detalle.Columnas]
Campo=269
Valor=304









[Detalle.ListaEnCaptura]
(Inicio)=VentaDWeb.Campo
VentaDWeb.Campo=VentaDWeb.Valor
VentaDWeb.Valor=(Fin)

[Campos]
Estilo=Hoja
Clave=Campos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaDWeb
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
ListaEnCaptura=VentaDWeb.Campo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroTipo=General
CarpetaVisible=S

HojaAjustarColumnas=S
OtroOrden=S
ListaOrden=VentaDWeb.Campo<TAB>(Acendente)
FiltroGeneral=VentaDWeb.ID = {Info.ID} AND VentaDWeb.Renglon = {Info.Renglon} AND VentaDWeb.RenglonSub = {Info.RenglonSub}
FiltroRespetar=S
[Campos.VentaDWeb.Campo]
Carpeta=Campos
Clave=VentaDWeb.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalles]
Estilo=Ficha
Clave=Detalles
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=VentaDWeb
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=VentaDWeb.Valor
CarpetaVisible=S

[Detalles.VentaDWeb.Valor]
Carpeta=Detalles
Clave=VentaDWeb.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=45x22
[Campos.Columnas]
Campo=275




































































[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S









[Forma.ListaCarpetas]
(Inicio)=Campos
Campos=Detalles
Detalles=(Fin)
