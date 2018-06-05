[Forma]
Clave=SabanaLiberarOrdenes
Nombre=Liberar Ordenes
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=527
PosicionInicialArriba=298
PosicionInicialAlturaCliente=108
PosicionInicialAncho=319
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
PosicionSec1=106
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Si(Info.Numero noen (1, 2, 3), Asigna(Info.Numero, 3))
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LiberarOrdenes
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

PestanaOtroNombre=S
PestanaNombre=Compras
CarpetaVisible=S
FiltroGeneral=UsuarioCfg2.Usuario=<T>{Usuario}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Ordenes
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Ficha.UsuarioCfg2.PlanOrdenCompra]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco













[Inv.UsuarioCfg2.GandhiPlanObservacion]
Carpeta=Inv
Clave=UsuarioCfg2.GandhiPlanObservacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco















[Forma.ListaCarpetas]
(Inicio)=Inv
Inv=Ficha
Ficha=(Fin)






[Ficha.ListaEnCaptura]
(Inicio)=UsuarioCfg2.PlanOrdenCompra
UsuarioCfg2.PlanOrdenCompra=UsuarioCfg2.PlanOrdenTraspaso
UsuarioCfg2.PlanOrdenTraspaso=(Fin)

[Ficha.UsuarioCfg2.PlanOrdenTraspaso]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenTraspaso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
