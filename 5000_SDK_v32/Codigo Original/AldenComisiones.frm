[Forma]
Clave=AldenComisiones
Nombre=Alden - Generar Comisiones
Icono=5
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=379
PosicionInicialArriba=328
PosicionInicialAltura=131
PosicionInicialAncho=266
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
PosicionInicialAlturaCliente=84
BarraHerramientas=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Ejercicio,  EjercicioTrabajo )<BR>Asigna(Info.Periodo,  PeriodoTrabajo )

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=4
FichaEspacioNombres=65
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Generar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreDesplegar=&Generar
Multiple=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>Comisiones<BR>Aceptar
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
AntesExpresiones=Asigna(Info.VerPendientes, Falso)

[Acciones.Generar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Generar.Comisiones]
Nombre=Comisiones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spAldenComisiones :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :nMes, :nAno<T>, EstacionTrabajo, Empresa, Sucursal, Usuario, Info.Periodo, Info.Ejercicio)<BR>Si(SQL(<T>SELECT COUNT(*) FROM ListaOk WHERE Estacion=:nEstacion<T>, EstacionTrabajo)>0, Forma(<T>ListaOk<T>))

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Periodo]
Carpeta=(Variables)
Clave=Info.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Ejercicio
Info.Ejercicio=Info.Periodo
Info.Periodo=(Fin)
