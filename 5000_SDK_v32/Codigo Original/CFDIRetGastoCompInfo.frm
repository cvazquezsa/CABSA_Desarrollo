

[Forma]
Clave=CFDIRetGastoCompInfo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=514
PosicionInicialArriba=333
PosicionInicialAlturaCliente=114
PosicionInicialAncho=358
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=CFDI Retenciones - Información Complementos
Comentarios=Info.Mov + <T> <T> + Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)
ListaAcciones=Cerrar
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetGastoComp
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
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CFDIRetGastoComplemento.ID = {Info.ID}
[Lista.CFDIRetGastoComplemento.Gravado]
Carpeta=Lista
Clave=CFDIRetGastoComplemento.Gravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.CFDIRetGastoComplemento.Exento]
Carpeta=Lista
Clave=CFDIRetGastoComplemento.Exento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetGastoComplemento.Gravado
CFDIRetGastoComplemento.Gravado=CFDIRetGastoComplemento.Exento
CFDIRetGastoComplemento.Exento=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

