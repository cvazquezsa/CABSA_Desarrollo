

[Forma]
Clave=CFDIRetGastoComp
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Guardar
PosicionInicialIzquierda=496
PosicionInicialArriba=283
PosicionInicialAlturaCliente=114
PosicionInicialAncho=358
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=CFDI Retenciones - Información Complementos
Comentarios=Info.Mov + <T> <T> + Info.MovID
ExpresionesAlMostrar=Asigna(Info.Dato,0)
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
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
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Acciones.Guardar]
Nombre=Guardar
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
(Inicio)=CFDIRetGastoComplemento.Gravado
CFDIRetGastoComplemento.Gravado=CFDIRetGastoComplemento.Exento
CFDIRetGastoComplemento.Exento=(Fin)

