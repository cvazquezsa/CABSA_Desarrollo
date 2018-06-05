[Forma]
Clave=ProyectoDesarrollo
Nombre=Datos Adicionales Desarrollo
Icono=0
Modulos=(Todos)
MovModulo=PROY
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=553
PosicionInicialArriba=288
PosicionInicialAlturaCliente=588
PosicionInicialAncho=814
PosicionSec1=209
ListaAcciones=(Lista)
PosicionCol2=395
PosicionCol1=393
Comentarios=Info.Mov+<T> <T>+Info.MovID
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Mov, SQL(<T>SELECT Mov FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.MovID, SQL(<T>SELECT MovID FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.Estatus, SQL(<T>SELECT Estatus FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.Proyecto, SQL(<T>SELECT Proyecto FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.Fecha, SQL(<T>SELECT FechaEmision FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.Moneda, SQL(<T>SELECT Moneda FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.TipoCambio, SQL(<T>SELECT TipoCambio FROM Proyecto WHERE ID = :nID<T>, Info.ID))<BR>Asigna(Info.Modulo, <T>PROY<T>)

[Ficha]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrollo
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
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)
FiltroGeneral=ProyectoDesarrollo.ID = {Info.ID}

[Ficha.ProyectoDesarrollo.Tipo]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Problema]
Estilo=Ficha
Clave=Problema
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ProyectoDesarrollo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProyectoDesarrollo.Problema
CarpetaVisible=S
PestanaNombre=Problema
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
AlinearTodaCarpeta=S
Pestana=S
PestanaOtroNombre=S
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)

[Problema.ProyectoDesarrollo.Problema]
Carpeta=Problema
Clave=ProyectoDesarrollo.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Problema.Columnas]
Problema=304

[Solucion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Solucion
Clave=Solucion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ProyectoDesarrollo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProyectoDesarrollo.Solucion
CarpetaVisible=S
AlinearTodaCarpeta=S
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)

[Solucion.ProyectoDesarrollo.Solucion]
Carpeta=Solucion
Clave=ProyectoDesarrollo.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.ProyectoDesarrollo.Clase1]
Carpeta=Clasificacion
Clave=ProyectoDesarrollo.Clase1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.ProyectoDesarrollo.Clase2]
Carpeta=Clasificacion
Clave=ProyectoDesarrollo.Clase2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.ProyectoDesarrollo.Clase3]
Carpeta=Clasificacion
Clave=ProyectoDesarrollo.Clase3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.ProyectoDesarrollo.Clase4]
Carpeta=Clasificacion
Clave=ProyectoDesarrollo.Clase4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.ProyectoDesarrollo.Clase5]
Carpeta=Clasificacion
Clave=ProyectoDesarrollo.Clase5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Evaluacion]
Nombre=Evaluacion
Boton=103
NombreDesplegar=Evaluaciones
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Clave, <T>PROY<T>+Info.ID)<BR>Asigna(Info.Nombre, Info.Mov+<T> <T>+Info.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Info.Estatus en (EstatusConcluido, EstatusCancelado, EstatusReestructurado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Anexo]
Nombre=Anexo
Boton=77
NombreDesplegar=Anexo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Fecha, Info.Fecha)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Info.Estatus noen (EstatusCancelado, EstatusConcluido, EstatusReestructurado))))<BR>Asigna(Info.Descripcion, Info.Mov+<T> <T>+Info.MovID)

[Acciones.Politica]
Nombre=Politica
Boton=22
NombreDesplegar=Politica
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Clave, Info.Mov)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=EjecutarSQL(<T>spProyectoDesarrolloAceptar :nID<T>, Info.ID)
DespuesGuardar=S

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
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar

[Acciones.Causas]
Nombre=Causas
Boton=91
NombreEnBoton=S
NombreDesplegar=Cau&sas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloCausa
Activo=S
Visible=S

[Acciones.Clasificacion]
Nombre=Clasificacion
Boton=91
NombreEnBoton=S
NombreDesplegar=C&lasificaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloClase1
Activo=S
Visible=S

[Ficha.ProyectoDesarrollo.Clase1]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Clase1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProyectoDesarrollo.Clase2]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Clase2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProyectoDesarrollo.Clase3]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Clase3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProyectoDesarrollo.Clase4]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Clase4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProyectoDesarrollo.Clase5]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Clase5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ProyectoDesarrollo.Causa]
Carpeta=OtrosDatos
Clave=ProyectoDesarrollo.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ProyectoDesarrollo.VersionCliente]
Carpeta=OtrosDatos
Clave=ProyectoDesarrollo.VersionCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.ProyectoDesarrollo.Causa]
Carpeta=Ficha
Clave=ProyectoDesarrollo.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProyectoDesarrollo.VersionCliente]
Carpeta=Ficha
Clave=ProyectoDesarrollo.VersionCliente
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Problema
Problema=Solucion
Solucion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Propiedades
Propiedades=Evaluacion
Evaluacion=Anexo
Anexo=Politica
Politica=Clasificacion
Clasificacion=Causas
Causas=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=ProyectoDesarrollo.Tipo
ProyectoDesarrollo.Tipo=ProyectoDesarrollo.VersionCliente
ProyectoDesarrollo.VersionCliente=ProyectoDesarrollo.Causa
ProyectoDesarrollo.Causa=ProyectoDesarrollo.Clase1
ProyectoDesarrollo.Clase1=ProyectoDesarrollo.Clase2
ProyectoDesarrollo.Clase2=ProyectoDesarrollo.Clase3
ProyectoDesarrollo.Clase3=ProyectoDesarrollo.Clase4
ProyectoDesarrollo.Clase4=ProyectoDesarrollo.Clase5
ProyectoDesarrollo.Clase5=(Fin)
