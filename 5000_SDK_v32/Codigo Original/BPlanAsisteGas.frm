[Forma]
Clave=BPlanAsisteGas
Icono=0
Modulos=(Todos)
Nombre=Asistente de Gastos
MovModulo=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=397
PosicionInicialArriba=411
PosicionInicialAlturaCliente=175
PosicionInicialAncho=486

[Lista]
Estilo=Ficha
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BPlanAsisteGas
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=BPlanAsisteGas.Estacion = {EstacionTrabajo}

[Lista.BPlanAsisteGas.Ejercicio]
Carpeta=Lista
Clave=BPlanAsisteGas.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.BPlanAsisteGas.Clasificacion]
Carpeta=Lista
Clave=BPlanAsisteGas.Clasificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlanAsisteGas.Inc]
Carpeta=Lista
Clave=BPlanAsisteGas.Inc
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.BPlanAsisteGas.Inc2]
Carpeta=Lista
Clave=BPlanAsisteGas.Inc2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.BPlanAsisteGas.Inc3]
Carpeta=Lista
Clave=BPlanAsisteGas.Inc3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.BPlanAsisteGas.Precio]
Carpeta=Lista
Clave=BPlanAsisteGas.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlanAsisteGas.Redondeo]
Carpeta=Lista
Clave=BPlanAsisteGas.Redondeo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.BPlanAsisteGas.Usar]
Carpeta=Lista
Clave=BPlanAsisteGas.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Aceptar<BR>SQL

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
EspacioPrevio=S

[Lista.BPlanAsisteGas.SubClasificacion]
Carpeta=Lista
Clave=BPlanAsisteGas.SubClasificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spBPlanSugiereGas :ntEstacion, :tEmpresa, :tModulo, :tUsuario, :tMon<T>, EstacionTrabajo, Empresa, Info.Modulo, Usuario, Info.Moneda)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=BPlanAsisteGas.Ejercicio
BPlanAsisteGas.Ejercicio=BPlanAsisteGas.Inc
BPlanAsisteGas.Inc=BPlanAsisteGas.Clasificacion
BPlanAsisteGas.Clasificacion=BPlanAsisteGas.Inc2
BPlanAsisteGas.Inc2=BPlanAsisteGas.SubClasificacion
BPlanAsisteGas.SubClasificacion=BPlanAsisteGas.Inc3
BPlanAsisteGas.Inc3=BPlanAsisteGas.Precio
BPlanAsisteGas.Precio=BPlanAsisteGas.Redondeo
BPlanAsisteGas.Redondeo=BPlanAsisteGas.Usar
BPlanAsisteGas.Usar=(Fin)
