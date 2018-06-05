
[Forma]
Clave=VentaCalcularPropEconomica
Icono=0
Modulos=(Todos)
Nombre=Venta Calcular Propuesta

ListaCarpetas=VentaCalcularPropEconomica
CarpetaPrincipal=VentaCalcularPropEconomica
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=409
PosicionInicialArriba=223
PosicionInicialAlturaCliente=284
PosicionInicialAncho=521
Comentarios=Info.Descripcion
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spProductosPropuestaEconomica :nID<T>, Info.ID)
[VentaCalcularPropEconomica]
Estilo=Iconos
Clave=VentaCalcularPropEconomica
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCalcularPropEconomica
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Material/Servicio<T>
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
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
IconosNombre=VentaCalcularPropEconomica:VentaCalcularPropEconomica.MaterialServicio
FiltroGeneral=VentaCalcularPropEconomica.ID={Info.ID}
[VentaCalcularPropEconomica.VentaCalcularPropEconomica.Costo]
Carpeta=VentaCalcularPropEconomica
Clave=VentaCalcularPropEconomica.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Asignar]
Nombre=Asignar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Asignar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S


ListaAccionesMultiples=(Lista)
[VentaCalcularPropEconomica.Columnas]
0=110
1=188






2=101
3=-2
[Acciones.Asignar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Numerico1, VentaCalcularPropEconomica:VentaCalcularPropEconomica.Renglon)<BR>Asigna(Info.Costo, VentaCalcularPropEconomica:VentaCalcularPropEconomica.Costo)
[Acciones.Asignar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Asignar.ActualizarOtraForma]
Nombre=ActualizarOtraForma
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=ProcesarSQL(<T>EXEC spPropuestaEconomicaActualizarCosto :nID, :nEstacion,  :tRenglon<T>, Info.ID, EstacionTrabajo, Info.Renglon)<BR>OtraForma(<T>Venta<T>, ActualizarVista )
[VentaCalcularPropEconomica.VentaCalcularPropEconomica.Descripcion]
Carpeta=VentaCalcularPropEconomica
Clave=VentaCalcularPropEconomica.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
















[Acciones.Asignar.AsignarListaSt]
Nombre=AsignarListaSt
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S























Expresion=RegistrarListaSt(<T>VentaCalcularPropEconomica<T>, <T>VentaCalcularPropEconomica.RenglonID<T>, RegistrarSeleccion(<T>VentaCalcularPropEconomica<T>))



[VentaCalcularPropEconomica.ListaEnCaptura]
(Inicio)=VentaCalcularPropEconomica.Descripcion
VentaCalcularPropEconomica.Descripcion=VentaCalcularPropEconomica.Costo
VentaCalcularPropEconomica.Costo=ArticuloDes
ArticuloDes=(Fin)

[VentaCalcularPropEconomica.ArticuloDes]
Carpeta=VentaCalcularPropEconomica
Clave=ArticuloDes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco














[Acciones.Asignar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=AsignarListaSt
AsignarListaSt=ActualizarOtraForma
ActualizarOtraForma=Cerrar
Cerrar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Asignar
Asignar=Cerrar
Cerrar=(Fin)
