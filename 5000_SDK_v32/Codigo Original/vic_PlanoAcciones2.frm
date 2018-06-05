
[Forma]
Clave=vic_PlanoAcciones2
Icono=4
Modulos=(Todos)
Nombre=Acciones del Planograma

ListaCarpetas=(Lista)
CarpetaPrincipal=vic_PlanoAcciones
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=644
PosicionInicialArriba=375
PosicionInicialAlturaCliente=251
PosicionInicialAncho=632
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
Comentarios=<T>Planograma <T> + Info.Plano
[vic_PlanoAcciones]
Estilo=Hoja
Clave=vic_PlanoAcciones
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_PlanoAcciones
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

CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Acciones
Pestana=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=vic_PlanoAcciones.Plano=<T>{Info.Plano}<T>
[vic_PlanoAcciones.vic_PlanoAcciones.Plano]
Carpeta=vic_PlanoAcciones
Clave=vic_PlanoAcciones.Plano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[vic_PlanoAcciones.vic_PlanoAcciones.Nombre]
Carpeta=vic_PlanoAcciones
Clave=vic_PlanoAcciones.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro




[vic_PlanoAcciones.vic_PlanoAcciones.Estatus]
Carpeta=vic_PlanoAcciones
Clave=vic_PlanoAcciones.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[vic_PlanoAcciones.Columnas]
Plano=95
Nombre=296
Query=604
LeyendaColor=124
Estatus=165



[Acciones.AccionesDef.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.AccionesDef]
Nombre=AccionesDef
Boton=47
NombreDesplegar=Detalle acción
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

NombreEnBoton=S


EspacioPrevio=S

GuardarAntes=S
Antes=S
ActivoCondicion=((ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Plano)) y<BR>(ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Nombre))) o<BR>((ConDatos(Info.Plano)) y<BR>(ConDatos(Info.Nombre)))
AntesExpresiones=Asigna(Info.Plano, vic_PlanoAcciones:vic_PlanoAcciones.Plano)<BR>Asigna(Info.Nombre, vic_PlanoAcciones:vic_PlanoAcciones.Nombre)
VisibleCondicion=1=2
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S


EspacioPrevio=S
RefrescarDespues=S
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_PlanoAcciones
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=12
FichaEspacioNombres=92
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.vic_PlanoAcciones.Nombre]
Carpeta=Detalle
Clave=vic_PlanoAcciones.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.vic_PlanoAcciones.Query]
Carpeta=Detalle
Clave=vic_PlanoAcciones.Query
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65x5
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.vic_PlanoAcciones.Estatus]
Carpeta=Detalle
Clave=vic_PlanoAcciones.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro


[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

EspacioPrevio=S




GuardarAntes=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.AccionesDef.vic_PlanoAccionesDef]
Nombre=vic_PlanoAccionesDef
Boton=0
TipoAccion=Formas
ClaveAccion=vic_PlanoAccionesDef
Activo=S
Visible=S


[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S


















[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Precaucion(<T>¿ Esta seguro que desea eliminar esta acción ?<T>+ NuevaLinea + NuevaLinea + <T>Acción <T> + vic_PlanoAcciones:vic_PlanoAcciones.Nombre, BotonSi, BotonNo ) = BotonSi<BR>Entonces EjecutarSQL(<T>vic_spEliminaAccionPlano :tPlano, :nRenglon<T>, vic_PlanoAcciones:vic_PlanoAcciones.Plano,vic_PlanoAcciones:vic_PlanoAcciones.Renglon)<BR>Sino<BR><T><T><BR>Fin
[Acciones.Eliminar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S







[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)














[vic_PlanoAcciones.ListaEnCaptura]
(Inicio)=vic_PlanoAcciones.Plano
vic_PlanoAcciones.Plano=vic_PlanoAcciones.Nombre
vic_PlanoAcciones.Nombre=vic_PlanoAcciones.Estatus
vic_PlanoAcciones.Estatus=(Fin)


[Acciones.AccionesDef.ListaAccionesMultiples]
(Inicio)=vic_PlanoAccionesDef
vic_PlanoAccionesDef=Actualizar Vista
Actualizar Vista=(Fin)













[Detalle.ListaEnCaptura]
(Inicio)=vic_PlanoAcciones.Nombre
vic_PlanoAcciones.Nombre=vic_PlanoAcciones.Estatus
vic_PlanoAcciones.Estatus=vic_PlanoAcciones.Query
vic_PlanoAcciones.Query=(Fin)





[Forma.ListaCarpetas]
(Inicio)=vic_PlanoAcciones
vic_PlanoAcciones=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=AccionesDef
AccionesDef=(Fin)
