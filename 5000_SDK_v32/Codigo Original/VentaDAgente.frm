[Forma]
Clave=VentaDAgente
Nombre=Actividades del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=524
PosicionInicialArriba=371
PosicionInicialAlturaCliente=421
PosicionInicialAncho=871
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Articulo, Info.Descripcion)
Totalizadores=S
PosicionSeccion1=91
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spSugerirArtActividad :tEmpresa, :nSucursal, :nID, :nRenglon, :nRenglonSub, :tArticulo, :nCantidad, :tAgente<T>, Empresa, Sucursal, Info.ID, Info.Renglon, Info.RenglonSub, Info.Articulo, Info.Cantidad, Info.Agente)
PosicionSec1=353

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaDAgente
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroAplicaEn=VentaDAgente.Estado
FiltroAutoCampo=VentaDAgente.Estado
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAutoOrden=TareaEstado.Orden
FiltroTodo=S
FiltroTodoFinal=S
FiltroGeneral=VentaDAgente.ID={Info.ID} AND<BR>VentaDAgente.Renglon={Info.Renglon} AND<BR>VentaDAgente.RenglonSub={Info.RenglonSub}

[Lista.VentaDAgente.Agente]
Carpeta=Lista
Clave=VentaDAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraD]
Carpeta=Lista
Clave=VentaDAgente.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraA]
Carpeta=Lista
Clave=VentaDAgente.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agente=79
HoraD=43
HoraA=39
Horas=36
Nombre=249
Fecha=65
Minutos=43
Tiempo=39
Actividad=268
Estado=83
FechaConclusion=88
TiempoEstandar=47
Avance=55

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Cantidad,  Conteo)

[Lista.VentaDAgente.Fecha]
Carpeta=Lista
Clave=VentaDAgente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Conteo<BR>Tiempo<BR>Estándar<BR>Diferencia
Totalizadores2=Conteo<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.Minutos))<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.CantidadEstandar*60))<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.Minutos)-Suma(VentaDAgente:VentaDAgente.CantidadEstandar*60))
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

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
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.VentaDAgente.Actividad]
Carpeta=Lista
Clave=VentaDAgente.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.Estado]
Carpeta=Lista
Clave=VentaDAgente.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.FechaConclusion]
Carpeta=Lista
Clave=VentaDAgente.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Lista.TiempoEstandar]
Carpeta=Lista
Clave=TiempoEstandar
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Gris

[(Carpeta Totalizadores).Tiempo]
Carpeta=(Carpeta Totalizadores)
Clave=Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Estándar]
Carpeta=(Carpeta Totalizadores)
Clave=Estándar
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Lista.VentaDAgente.Avance]
Carpeta=Lista
Clave=VentaDAgente.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaDAgente.Actividad
VentaDAgente.Actividad=VentaDAgente.Estado
VentaDAgente.Estado=VentaDAgente.Avance
VentaDAgente.Avance=VentaDAgente.FechaConclusion
VentaDAgente.FechaConclusion=VentaDAgente.Agente
VentaDAgente.Agente=VentaDAgente.Fecha
VentaDAgente.Fecha=VentaDAgente.HoraD
VentaDAgente.HoraD=VentaDAgente.HoraA
VentaDAgente.HoraA=Tiempo
Tiempo=TiempoEstandar
TiempoEstandar=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Agente.Nombre
Agente.Nombre=VentaDAgente.Comentarios
VentaDAgente.Comentarios=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Tiempo
Tiempo=Estándar
Estándar=Diferencia
Diferencia=Conteo
Conteo=(Fin)
