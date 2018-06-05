
[Forma]
Clave=vic_PlanoLista
Icono=0
Modulos=(Todos)
Nombre=Planos Disponibles

ListaCarpetas=vic_Plano
CarpetaPrincipal=vic_Plano
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=562
PosicionInicialArriba=304
PosicionInicialAlturaCliente=393
PosicionInicialAncho=796
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
Comentarios=<T>Copiar del Planograma: <T> + Info.Plano
ListaAcciones=(Lista)
[vic_Plano]
Estilo=Iconos
PestanaOtroNombre=S
Clave=vic_Plano
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_Plano
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Plano<T>
IconosConPaginas=S
ElementosPorPagina=200
IconosSeleccionMultiple=S
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
IconosNombre=vic_Plano:vic_Plano.Plano
FiltroGeneral=vic_Plano.Plano<><T>{Info.Plano}<T>
[vic_Plano.vic_Plano.NombreCorto]
Carpeta=vic_Plano
Clave=vic_Plano.NombreCorto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[vic_Plano.vic_Plano.Nombre]
Carpeta=vic_Plano
Clave=vic_Plano.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco

[vic_Plano.vic_Plano.Estatus]
Carpeta=vic_Plano
Clave=vic_Plano.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[vic_Plano.Columnas]
0=-2
1=-2
2=211
3=113
4=125
5=-2

[Acciones.Copiar]
Nombre=Copiar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Copiar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=controles Captura
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
NombreDesplegar=C&ancelar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
EspacioPrevio=S


[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)







[Acciones.Copiar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=RegistrarSeleccion( <T>vic_Plano<T> )<BR>ProcesarSQL(<T>vic_spCopiaAccionesPlano :tPlano, :nEstacion<T>, Info.Plano, EstacionTrabajo)
Activo=S
Visible=S

[Acciones.Copiar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Copiar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)







[vic_Plano.ListaEnCaptura]
(Inicio)=vic_Plano.NombreCorto
vic_Plano.NombreCorto=vic_Plano.Nombre
vic_Plano.Nombre=vic_Plano.Estatus
vic_Plano.Estatus=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Copiar
Copiar=Cancelar
Cancelar=(Fin)
