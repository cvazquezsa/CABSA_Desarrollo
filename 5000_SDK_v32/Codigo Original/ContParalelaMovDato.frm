
[Forma]
Clave=ContParalelaMovDato
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad Paralela - Datos Movimiento
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaExclusivaOpcion=2
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=ContParalelaMovDato
CarpetaPrincipal=ContParalelaMovDato
PosicionInicialIzquierda=497
PosicionInicialArriba=280
PosicionInicialAlturaCliente=129
PosicionInicialAncho=372
ListaAcciones=GuardarCerrar
BarraHerramientas=S
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spContParalelaMovDatoI :tModulo, :nModuloID<T>, Info.Modulo, Info.ID)
[ContParalelaMovDato]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=ContParalelaMovDato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaMovDato
Fuente={Tahoma, 8, Negro, []}
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ContParalelaMovDato.Modulo = <T>{Info.Modulo}<T> AND ContParalelaMovDato.ModuloID = <T>{Info.ID}<T>
FiltroRespetar=S
FiltroTipo=General
[ContParalelaMovDato.ContParalelaMovDato.Fecha]
Carpeta=ContParalelaMovDato
Clave=ContParalelaMovDato.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[ContParalelaMovDato.ContParalelaMovDato.Moneda]
Carpeta=ContParalelaMovDato
Clave=ContParalelaMovDato.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ContParalelaMovDato.ContParalelaMovDato.TipoCambio]
Carpeta=ContParalelaMovDato
Clave=ContParalelaMovDato.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





Tamano=15

[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[ContParalelaMovDato.ListaEnCaptura]
(Inicio)=ContParalelaMovDato.Fecha
ContParalelaMovDato.Fecha=ContParalelaMovDato.Moneda
ContParalelaMovDato.Moneda=ContParalelaMovDato.TipoCambio
ContParalelaMovDato.TipoCambio=(Fin)
