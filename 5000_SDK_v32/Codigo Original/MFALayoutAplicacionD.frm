
[Forma]
Clave=MFALayoutAplicacionD
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=<T>MFA - Captura manual aplicaciones<T>

ListaCarpetas=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=421
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=219
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Ejercicio,Info.Periodo,Info.MovID)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutAplicacionD
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=MFALayoutAplicacionD.DocumentoID = {Comillas(Info.Categoria)}
[Lista.MFALayoutAplicacionD.referencia]
Carpeta=Lista
Clave=MFALayoutAplicacionD.referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFALayoutAplicacionD.importe]
Carpeta=Lista
Clave=MFALayoutAplicacionD.importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutAplicacionD.cuenta_bancaria]
Carpeta=Lista
Clave=MFALayoutAplicacionD.cuenta_bancaria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
referencia=131
importe=64
cuenta_bancaria=177

0=84
1=111
2=-2

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=MFALayoutAplicacionD.referencia
MFALayoutAplicacionD.referencia=MFALayoutAplicacionD.importe
MFALayoutAplicacionD.importe=MFALayoutAplicacionD.cuenta_bancaria
MFALayoutAplicacionD.cuenta_bancaria=(Fin)
