[Forma]
Clave=CalcSueldoDiario
Nombre=Calcular Sueldo Diario
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=536
PosicionInicialArriba=286
PosicionInicialAltura=132
PosicionInicialAncho=294
AccionesTamanoBoton=15x5
BarraAcciones=S
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=118

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Sueldo]
Carpeta=(Variables)
Clave=Info.Sueldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.PeriodoTipo]
Carpeta=(Variables)
Clave=Info.PeriodoTipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Calcular]
Nombre=Calcular
Boton=0
NombreDesplegar=&Calcular
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Calcular.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Calcular.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Temp.Reg, SQL(<T>spVerNominaCalculoInverso :tEmpresa, :nSueldo, :tPeriodo, :Anos, :tPersonal<T>, Empresa, Info.Sueldo, Info.PeriodoTipo, Info.Anos, Info.Personal))<BR><BR>Si(<BR>Informacion(<BR><T>Sueldo Antes Impuestos: <T>+MonetarioEnTexto(Temp.Reg[1])+NuevaLinea+<BR><T>Sueldo Diario: <T>+MonetarioEnTexto(Temp.Reg[2]), BotonAceptar, BotonCancelar)=BotonAceptar, <BR>Asigna(Info.Sueldo, Temp.Reg[2]), <BR>Asigna(Temp.Monetario, Nulo)<BR>)

[Acciones.Calcular.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Temp.Monetario)


[(Variables).ListaEnCaptura]
(Inicio)=Info.Sueldo
Info.Sueldo=Info.PeriodoTipo
Info.PeriodoTipo=(Fin)











[Forma.ListaAcciones]
(Inicio)=Calcular
Calcular=Cancelar
Cancelar=(Fin)
