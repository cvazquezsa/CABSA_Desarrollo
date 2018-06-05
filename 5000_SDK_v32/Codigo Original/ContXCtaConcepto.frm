[Forma]
Clave=ContXCtaConcepto
Icono=0
Modulos=(Todos)
Nombre=<T>Cuentas por Concepto - <T>+Info.Descripcion
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=182
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=660
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContXCtaConcepto
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=ContXCtaConcepto.Modulo=<T>{Info.Modulo}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.ContXCtaConcepto.Concepto]
Carpeta=Lista
Clave=ContXCtaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContXCtaConcepto.Cuenta]
Carpeta=Lista
Clave=ContXCtaConcepto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=214
Cuenta=124
Descripcion=292

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=ContXCtaConcepto.Concepto
ContXCtaConcepto.Concepto=ContXCtaConcepto.Cuenta
ContXCtaConcepto.Cuenta=Cta.Descripcion
Cta.Descripcion=(Fin)
